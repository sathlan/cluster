class MachineNics
  attr_reader :root
  attr_reader :parent_of
  attr_reader :children
  def initialize(machine_name)
    @root = machine_name
    # here, a nic is a hash.  This could be a class.
    @children = Hash.new([])
    @parent_of = Hash.new([])
  end

  def add(root,nics)
    @children[root] = nics
    nics.each {|nic| parent_of[nic] = root}
  end

  # parse a hash of hash of any depth with the machine name as unique
  # root.  Some syntaxic sugar is present for leaf.  Check the
  # sanitize function.
  #
  # Ex: { bridge0: {tap101: nil, tap102: nil}} can be written:
  #     { bridge0: [ tap101, tap102 ]}
  # this works too: {brigde0: [{ lagg0: [tap200, tap201] }, tap100]
  # and is equivaleunt to {bridge0: {lagg0: {tap200: nil, tap201: nil}, tap100: nil}

  def self.create_from_hash(description)
    machine = MachineNics.new(description.first[0])
    current_roots = []

    sanitized_values = sanitize(description[machine.root])
    machine.add(machine.root, sanitized_values.keys)
    current_roots = [sanitized_values]

    until current_roots.empty?
      current_roots.each do |current_root|
        current_roots = []
        current_root.each_key do |root|
          unless current_root[root].nil?
            sanitized_current_root = sanitize(current_root[root])
            machine.add(root, sanitized_current_root.keys)
            current_roots.push(sanitized_current_root)
          end
        end
      end
    end

    machine
  end

  def length(root)
    max = 0
    traverse(root,0) {|n, l| max = l if l > max }
    max
  end

  def traverse(node,level,&block)
    yield node, level if block_given?
    @children[node].each { |child| traverse(child, level+1, &block) }
  end

  def traverse_df(node,level,&block)
    # depth first and deepest first.
    @children[node].sort_by {|a| length(a) }.reverse.each { |child| traverse_df(child, level+1, &block) }
    yield node, level if block_given?
  end

  def display
    puts @root.to_s + " " + "=" * 10
    traverse(@root,0) {|n, l| puts "  "*l + "node: #{n}"}
    self
  end
  def display_df
    puts @root.to_s + " df*" + "=" * 10
    traverse_df(@root,0) {|n, l| puts "  "*l + "*node: #{n}"}
    self
  end
  def up
    traverse_df(@root,0) do |nic, level|
      `sudo ifconfig #{remove_mtu_from_name(nic)} up 2>/dev/null`
    end
  end
  def create
    traverse_df(@root,0) do |nic, level|
      return unless level > 0
      cmd = dispatch('create', nic)
      prefix = "  "*level
      puts "#{prefix}* Creating #{nic.upcase} "
      cmd.flatten.each {|c| puts prefix + "  #{c}"}
      out = cmd.flatten.each {|c| `#{c} 2>/dev/null`}
    end
  end
  def dispatch(cmd, nic)
    function = nic.to_s.sub(/^(?:\/dev\/)?([^0-9_]+)[\d_]+/,'\1')
    return send(function + '_' + cmd, nic)
  end
  def tap_empty?(name)
    true
  end
  def lagg_empty?(name)
    composite_empty?(name, 'laggport')
  end
  def bridge_empty?(name)
    composite_empty?(name, 'member')
  end
  def vlan_empty?(name)
    true
  end
  def composite_empty?(name, port_name)
    cmd = %Q{ifconfig #{remove_mtu_from_name(name)} | awk '/#{port_name}:/{print $2}'}
    `#{cmd}`.split.empty?
  end

  def destroy
    traverse_df(@root,0) do |name, level|
      next if level == 0
      next unless dispatch('empty?', name)
      cmd = "sudo ifconfig #{remove_mtu_from_name(name)} destroy 2>/dev/null"
      puts "  "*level + "* #{cmd}"
      out = `#{cmd}`
    end
  end

  def mtu_by_name(name)
    name.to_s.sub(/.*_(.*)/, '\1')
  end
  def remove_mtu_from_name(name)
    name.to_s.sub(/(.*)_.*/, '\1')
  end
  def tap_create(name)
    mtu = mtu_by_name(name)
    name_without_mtu = remove_mtu_from_name(name)
    cmd = ["sudo ifconfig #{name_without_mtu} create mtu #{mtu}"]
  end

  def lagg_create(name)
    cmd = "sudo ifconfig #{name} create laggproto loadbalance "
    children[name].each do |nic|
      cmd += " laggport #{remove_mtu_from_name(nic)} "
    end
    [cmd]
  end
  def bridge_create(name)
    cmd_before = "sudo ifconfig #{name} create 2>/dev/null; "
    cmd_pre = "sudo ifconfig #{name} "
    cmds = []
    children[name].each do |nic|
      cmds << "#{cmd_pre} addm #{remove_mtu_from_name(nic)} "
    end
    cmd = [cmd_before, cmds]
  end
  def get_vid_from_name(name)
    # several vlan with the same vid but not the same name:
    # vlan10100 vlan10101, ...
    vid = ""
    if name.to_s.length > 8
      l = name.to_s.length - 2 - 4
      vid = name.to_s[4,l]
    else
      vid = name.to_s.gsub(/\D+/,'')
    end
    vid
  end
  def vlan_create(name)
    vid = get_vid_from_name(name)
    cmd = ["sudo ifconfig #{name} create vlan #{vid} vlandev #{remove_mtu_from_name(children[name].first)}"]
  end

  private
  # syntaxic sugar.  We expect an hash of a hash, but for terminal
  # node, we can take array or symbol.  Transforme the structure here
  # to make it fit our requirements.
  def self.sanitize(hash_or_array)
    hash = {}
    if hash_or_array.class.name == "Array"
      hash_or_array.each do |element|
        # each eleement can be a terminal nic or a composed nic.
        if element.class.name == "Symbol"
          hash[element] = nil
        else
          element.each_key do |nic|
            hash[nic] = element[nic]
          end
        end
      end
    elsif hash_or_array.class.name == "Symbol"
      hash = {}
      hash[hash_or_array] = nil
    else
      hash = hash_or_array
    end
    hash
  end

end

# -> goal: { bridge0: { vlan101: { lagg0: [:tap200, :tap201] }}}

