# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  config.vm.define :b1 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "b1"
    config.vm.network :bridged, { bridge: 'tap100', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap101', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap200', nic_type: 'virtio', auto_config: false }
    config.vm.provision :puppet do |puppet|
      puppet.manifest_file = "b1.pp"
    end
  end

  config.vm.define :b2 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "b2"
    config.vm.network :bridged, { bridge: 'tap102', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap103', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap201', nic_type: 'virtio', auto_config: false }
    config.vm.provision :puppet do |puppet|
      puppet.manifest_file = "b2.pp"
    end
  end

  config.vm.define :fw1 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "fw1"
    config.vm.network :bridged, { bridge: 'tap104', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap105', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap106', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap107', nic_type: 'virtio', auto_config: false }
  end

  config.vm.define :fw2 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "fw2"
    config.vm.network :bridged, { bridge: 'tap109', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap110', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap111', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap112', nic_type: 'virtio', auto_config: false }
  end

  config.vm.define :mon_1 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "mon-1"
    config.vm.network :bridged, { bridge: 'tap113', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap114', nic_type: 'virtio', auto_config: false }
  end

  config.vm.define :mon_2 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "mon-2"
    config.vm.network :bridged, { bridge: 'tap115', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap116', nic_type: 'virtio', auto_config: false }
  end

  config.vm.define :dns_mx_1 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "dns-mx-1"
    config.vm.network :bridged, { bridge: 'tap117', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap118', nic_type: 'virtio', auto_config: false }
  end

  config.vm.define :dns_mx_2 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "dns-mx-2"
    config.vm.network :bridged, { bridge: 'tap119', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap120', nic_type: 'virtio', auto_config: false }
  end

  config.vm.define :backup_1 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "backup-1"
    config.vm.network :bridged, { bridge: 'tap121', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap122', nic_type: 'virtio', auto_config: false }
  end

  config.vm.define :backup_2 do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "backup-2"
    config.vm.network :bridged, { bridge: 'tap123', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap124', nic_type: 'virtio', auto_config: false }
  end

  config.vm.define :puppet do |config|
    config.vm.box = "ehaelix-0.0.2"
    config.vm.box_url = "http://dev-2.lan.enovance.com/ehaelix-0.0.2.box"
    config.vm.host_name = "puppet"
    config.vm.network :bridged, { bridge: 'tap125', nic_type: 'virtio', auto_config: false }
    config.vm.network :bridged, { bridge: 'tap126', nic_type: 'virtio', auto_config: false }
  end

  # Every Vagrant virtual environment requires a box to build off of.

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  # config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # config.vm.network :hostonly, "33.33.33.10"

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
#  config.vm.network :bridged, {bridge: 'tap95'}
#  config.vm.network :bridged, {bridge: 'tap96'}
#  config.vm.network :bridged, {bridge: 'tap97'}
#  config.vm.network :bridged
#  config.vm.network :bridged
#  config.vm.network :bridged
#  config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port "http", 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  # config.vm.share_folder "v-data", "/vagrant_data", "../data"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file luci32_base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "luci32_base.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path (relative
  # to this Vagrantfile), and adding some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "cookbooks"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # IF you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
