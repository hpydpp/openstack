
class openstack::customize::cnstack {

  # replace logo
  file { '/usr/share/openstack-dashboard/static/dashboard/img/logo.png':
    source => 'puppet:///modules/openstack/logo.png'   
  }

  # replace favico
  file { '/usr/share/openstack-dashboard/static/dashboard/img/favicon.ico':
    source => 'puppet:///modules/openstack/favicon.ico',
  }

  # login logo
  file { '/usr/share/openstack-dashboard/static/dashboard/img/logo-splash.png':
    source => 'puppet:///modules/openstack/logo-splash.png',
  }

  # replace i18n file
  file { '/usr/share/openstack-dashboard/openstack_dashboard/locale/zh_CN/LC_MESSAGES/django.mo':
    source => 'puppet:///modules/openstack/django.mo',
  } 

  # replace limits.conf
  file { '/etc/security/limits.conf':
    source => 'puppet:///modules/openstack/limits.conf',
  }
  
  file { '/root/dashboard.sh' :
    source => 'puppet:///modules/openstack/dashboard.sh',
  } ->
  
  exec { 'sh /root/dashboard.sh' :
    command => '/bin/sh /root/dashboard.sh',
    user => 'root'
  }

  file { '/root/mariadb.sh' :
    source => 'puppet:///modules/openstack/mariadb.sh',
  } ->

  exec { 'sh /root/mariadb.sh':
    command => '/bin/sh /root/mariadb.sh',
    user => 'root',
  }

  #Service['httpd']

  # replace settings
  #file { '/usr/share/openstack-dashboard/openstack_dashboard/settings.py':
  # source => 'TODO',
  #}

  # upgrade mariadb
}

