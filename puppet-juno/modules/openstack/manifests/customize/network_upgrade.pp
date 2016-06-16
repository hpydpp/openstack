
class openstack::customize::network_upgrade {
  package { 'dnsmasq.x86_64':
    ensure => latest
  } ->

  /*
  service  { 'dnsmasq':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
 */ 

  /*file { '/usr/sbin/dnsmasq':
    ensure => 'link',
    target => '/usr/local/sbin/dnsmasq',
  } */

  file { '/usr/sbin/dnsmasq':
	ensure => file,
	source => "/usr/local/sbin/dnsmasq",
  } ->
  
  file { '/usr/local/sbin/dnsmasq':
	ensure => absent,
  }

}

