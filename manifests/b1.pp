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
        "set auto[child::1 = 'vzbr3100']/1 vzbr3100",
        "set iface[. = 'vzbr3100'] vzbr3100",
        "set iface[. = 'vzbr3100']/family inet",
        "set iface[. = 'vzbr3100']/method static",
        "set iface[. = 'vzbr3100']/bridge_ports bond0.3100",
        "set iface[. = 'vzbr3100']/bridge_maxwait 0",
        "set iface[. = 'vzbr3100']/bridge_fd 0",
        "set iface[. = 'vzbr3100']/address 172.143.115.36",
        "set iface[. = 'vzbr3100']/netmask 255.255.255.224",
        "set auto[child::1 = 'eth3']/1 eth3",
        "set iface[. = 'eth3'] eth3",
        "set iface[. = 'eth3']/family inet",
        "set iface[. = 'eth3']/method static",
        "set iface[. = 'eth3']/address 172.16.0.201",
        "set iface[. = 'eth3']/netmask 255.255.255.0",
    ],
}
