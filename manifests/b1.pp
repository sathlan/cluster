import 'bl-common'
class {'vagrant::init::bl':
  vlan3401_addr  => '172.143.114.197',
  drbd_addr      => '172.16.0.201',
}
