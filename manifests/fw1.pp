# TODO: Requires ifenslave.

# TODO: on linux bond0 must be set to promisc mode:  ifconfig bond0
# promisc as well as all the nics in virtualbox. see
# https://www.virtualbox.org/ticket/4214
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
        "set iface[. = 'bond0.101']/address 172.143.112.71",
        "set iface[. = 'bond0.101']/netmask 255.255.255.192",
        "set iface[. = 'bond0.101']/gateway 255.255.255.192",
        "set auto[child::1 = 'bond1.3401']/1 bond1.3401",
        "set iface[. = 'bond1.3401'] bond1.3401",
        "set iface[. = 'bond1.3401']/family inet",
        "set iface[. = 'bond1.3401']/method static",
        "set iface[. = 'bond1.3401']/address 172.143.114.195",
        "set iface[. = 'bond1.3401']/netmask 255.255.255.224",
    ],
}
