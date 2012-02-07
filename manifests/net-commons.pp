define vagrant::init::networking($cmd){
  exec { 'networking':
    command => "$cmd",
    path => "/usr/bin:/usr/sbin:/bin:/sbin",
    creates => "/sys/class/net/bond1.3401",
    require => [ Package["ifupdown"], Package["ifenslave-2.6"] ],
    timeout => 10,
  }
}

exec { "killall dhclient" :
  onlyif => 'ps faux | grep -q "[d]hcp.*eth0"',
  path => "/usr/bin:/usr/sbin:/bin",
}
exec { "ip route del default dev eth0":
  onlyif => 'ip route | grep "default.*[e]th0"',
  path => "/usr/bin:/usr/sbin:/bin",
}

package { "ifenslave-2.6":
  ensure => installed,
  before => Exec["ip route del default dev eth0"]
}

package { "ifupdown":
  ensure => installed,
  before => Exec["ip route del default dev eth0"]
}
# ifup, doesn't not really 'reload' conf.  Don't count too much on it.
Augeas["bond_interfaces"] ~> Exec["networking"]
