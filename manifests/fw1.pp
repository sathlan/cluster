import 'fw-common'

class {'vagrant::init::fw':
  ip_address       => '172.143.112.71',
  vlan3401_address => '172.143.114.195',
}
