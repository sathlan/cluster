# TODO: rmmod virtio-pci, rm udev -> 70-persi-net, modprobe
# virtio-pci.  This sequence makes sure that interface are well
# numbererd.
import 'net-commons'
vagrant::init::networking {'bl-network' :
  cmd => "ifup bond0; ifup vzbr3401; ifup eth3",
}
class vagrant::init::bl ($vlan3401_addr, $drbd_addr) {
  augeas { "bond_interface" :
    context => "/files/etc/network/interfaces",
    changes => [
                "set auto[child::1 = 'bond0']/1 bond0",
                "set iface[. = 'bond0'] bond0",
                "set iface[. = 'bond0']/family inet",
                "set iface[. = 'bond0']/method manual",
                "set iface[. = 'bond0']/bond-slaves 'eth1 eth2'",
                "set iface[. = 'bond0']/bound-mode balance-xor",
                "set iface[. = 'bond0']/bond-miimon 100",
                "set iface[. = 'bond0']/bond-downdelay 200",
                "set iface[. = 'bond0']/bond-updelay 200",
                "set iface[. = 'bond0']/bond-xmit_hash_policy layer3+4",
                "set auto[child::1 = 'vzbr3401']/1 vzbr3401",
                "set iface[. = 'vzbr3401'] vzbr3401",
                "set iface[. = 'vzbr3401']/family inet",
                "set iface[. = 'vzbr3401']/method static",
                "set iface[. = 'vzbr3401']/bridge_ports bond0.3401",
                "set iface[. = 'vzbr3401']/bridge_maxwait 0",
                "set iface[. = 'vzbr3401']/bridge_fd 0",
                "set iface[. = 'vzbr3401']/address $vlan3401_addr",
                "set iface[. = 'vzbr3401']/netmask 255.255.255.224",
                "set iface[. = 'vzbr3401']/gateway 172.143.114.195",
                "set auto[child::1 = 'eth3']/1 eth3",
                "set iface[. = 'eth3'] eth3",
                "set iface[. = 'eth3']/family inet",
                "set iface[. = 'eth3']/method static",
                "set iface[. = 'eth3']/address $drbd_addr",
                "set iface[. = 'eth3']/netmask 255.255.255.0",
                ],
    before => Exec["networking"],
  }
}
