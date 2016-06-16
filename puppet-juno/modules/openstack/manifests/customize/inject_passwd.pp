
class openstack::customize::inject_passwd {

  file { '/root/inject_passwd.sh' :
    source => 'puppet:///modules/openstack/inject_passwd.sh',
  } ->
  
  exec { 'sh /root/inject_passwd.sh' :
    command => '/bin/sh /root/inject_passwd.sh',
    user => 'root'
  }

}

