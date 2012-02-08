require 'rbconfig'
require 'machine-nics'
require 'yaml'
NET_CONFIGUATION = 'network.yml'

BRDG = YAML.load_file(NET_CONFIGUATION)

BRDG.each_key do |host|
  desc "Make nics for #{host}"
  tree = MachineNics::Tree.create_from_hash({host => BRDG[host]})
  actions = MachineNics::Actions.new(RbConfig::CONFIG['host_os'])
  task "nics_#{host}" do |t|
    tree.traverse_df(tree.root, 0) do |nic, level|
      next if level <= 0
      actions.display('create', nic, level, tree.children[nic] )
      actions.create!(nic, tree.children[nic], tree)
    end
  end
  desc "Destroy nics for #{host}"
  task "rem_nics_for_#{host}" do |t|
    tree.traverse_df(tree.root, 0) do |nic, level|
      next if level <= 0
      actions.display('destroy', nic, level, tree.children[nic] )
      actions.destroy!(nic, tree.children[nic])
    end
  end
end

desc "Destroy everything."
task clobber: [:Rem_ip] do |t|
  BRDG.each_key do |host|
    tree = MachineNics::Tree.create_from_hash({host => BRDG[host]})
    actions = MachineNics::Actions.new(RbConfig::CONFIG['host_os'])
    tree.traverse_df(tree.root, 0) do |nic, level|
      next if level <= 0
      actions.display('destroy', nic, level, tree.children[nic] )
      actions.destroy!(nic, tree.children[nic])
    end
  end
end

desc "Add cluster ehaelix"
task add_blastors: [:nics_b1, :nics_b2]

desc "Remove cluster ehaelix"
task rem_blastors: [:rem_nics_for_b1, :rem_nics_for_b2]

desc "Add cluster FW"
task add_fws: [:nics_fw1, :nics_fw2]

desc "Add ips routers for freebsd"
task :add_ip_freebsd do |t|
  if `ifconfig vlan101 2>/dev/null`.split.empty?
    `sudo ifconfig vlan10100  172.143.112.67/26`
  else
    `sudo ifconfig vlan101  172.143.112.67/26`
  end
  `sudo sysctl net.inet.ip.forwarding=1`
  `sudo sysctl net.link.bridge.ipfw=0`
  `sudo sysctl net.link.bridge.pfil_local_phys=0`
  `sudo sysctl net.link.bridge.pfil_member=0`
  `sudo sysctl net.link.bridge.pfil_bridge=0`
  `sudo sysctl net.link.bridge.ipfw_arp=0`
  `sudo sysctl net.link.bridge.pfil_onlyip=0`
  `sudo /etc/rc.d/pf reload`
  `sudo route add 172.143.115.35/27  172.143.112.71` # router cfg
  `sudo route add 172.143.114.192/27 172.143.112.71` # router cfg
end

desc "Add ips routers for linux"
task :add_ip_linux do |t|
  `sudo modprobe bonding 2>&1 >/dev/null; sudo modprobe 8021q 2>&1 >/dev/null;`
  # seems it cannot be on the laggX.101 interface.
  `sudo ifconfig bridge0 172.143.112.67/26`
  `sudo sysctl net.ipv4.ip_forward=1`
  `sudo sh -c 'if=$(ip r |awk "/default/{print \\$NF}");ip=$(ip a show $if | awk "/inet /{print \\$2}" | cut -d"/" -f1) ; iptables -I POSTROUTING 1 -t nat -o $if \! -s $ip -j SNAT --to $ip'`
  `sudo ip r add 172.143.115.32/27 via 172.143.112.71` # router cfg
  `sudo ip r add 172.143.114.192/27 via 172.143.112.71` # router cfg
end

desc "Remove ips routers for freebsd"
task :rem_ip_freebsd do |t|
  `sudo route del 172.143.115.35/27  172.143.112.71` # router cfg
  `sudo route del 172.143.114.192/27 172.143.112.71` # router cfg
  `sudo ifconfig vlan10100 -alias 172.143.112.67 2>/dev/null`
  `sudo ifconfig vlan101   -alias 172.143.112.67 2>/dev/null`
end

desc "Remove ips routers for linux"
task :rem_ip_linux do |t|
  `sudo ip r del 172.143.115.32/27 via 172.143.112.71` # router cfg
  `sudo ip r del 172.143.114.192/27 via 172.143.112.71` # router cfg
  `sudo ip a flush lagg4.101 2>/dev/null`
  `sudo ip a flush lagg2.101 2>/dev/null`
  `sudo sh -c 'if=$(ip r |awk "/default/{print \\$NF}");ip=$(ip a show $if | awk "/inet /{print \\$2}" | cut -d"/" -f1) ; iptables -D POSTROUTING -t nat -o $if \! -s $ip -j SNAT --to $ip'`
end

task_name_rem_ip = 'Rem_ip_' + RbConfig::CONFIG['host_os'].downcase.gsub(/\d/,'').gsub(/-.*/,'')
task_name_rem_ip = task_name_rem_ip.to_sym
task_name_add_ip = 'Add_ip_' + RbConfig::CONFIG['host_os'].downcase.gsub(/\d/,'').gsub(/-.*/,'')
task_name_add_ip = task_name_add_ip.to_sym

desc "Remove ips routers for your plateform"
task rem_ip: [task_name_rem_ip]

desc "Add ips routers for your plateform"
task add_ip: [task_name_add_ip]

desc "Remove cluster FW"
task rem_fws: [:rem_nics_for_fw1, :rem_nics_for_fw2]

desc "Add eNovance"
task add_enovance: [:add_blastors, :add_fws, :add_ip]

desc "Add eNovance Small: fw1, b1, puppet"
task add_enovance_small: [:nics_b1, :nics_fw1, :nics_puppet, :add_ip ]

desc "Remove eNovance Small: fw1, b1, puppet"
task rem_enovance_small: [:rem_nics_for_b1, :rem_nics_for_fw1, :rem_nics_for_puppet, :rem_ip ]

desc "Remove eNovance"
task rem_enovance: [:rem_ip, :rem_fws, :rem_blastors ]

