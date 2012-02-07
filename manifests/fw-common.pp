# $vlan3401_address is temporary.  Later, it will be notified to
# create it by a puppet master.  Will be nice.
import 'net-commons'
vagrant::init::networking {'fw-network' :
  cmd => "ifup bond0; ifup bond1; ifup bond0.101; ifup bond1.3401;",
}
class vagrant::init::fw ($ip_address, $vlan3401_address) {
  augeas { "bond_interfaces" :
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
                "set auto[child::1 = 'bond1']/1 bond1",
                "set iface[. = 'bond1'] bond1",
                "set iface[. = 'bond1']/family inet",
                "set iface[. = 'bond1']/method manual",
                "set iface[. = 'bond1']/bond-slaves 'eth3 eth4'",
                "set iface[. = 'bond1']/bound-mode balance-xor",
                "set iface[. = 'bond1']/bond-miimon 100",
                "set iface[. = 'bond1']/bond-downdelay 200",
                "set iface[. = 'bond1']/bond-updelay 200",
                "set iface[. = 'bond1']/bond-xmit_hash_policy layer3+4",
                "set auto[child::1 = 'bond0.101']/1 bond0.101",
                "set iface[. = 'bond0.101'] bond0.101",
                "set iface[. = 'bond0.101']/family inet",
                "set iface[. = 'bond0.101']/method static",
                "set iface[. = 'bond0.101']/address $ip_address",
                "set iface[. = 'bond0.101']/netmask 255.255.255.192",
                "set iface[. = 'bond0.101']/gateway 172.143.112.67",
                "set auto[child::1 = 'bond1.3401']/1 bond1.3401",
                "set iface[. = 'bond1.3401'] bond1.3401",
                "set iface[. = 'bond1.3401']/family inet",
                "set iface[. = 'bond1.3401']/method static",
                "set iface[. = 'bond1.3401']/address $vlan3401_address",
                "set iface[. = 'bond1.3401']/netmask 255.255.255.224",
                ],
  }
}
