class openstack::role::network inherits ::openstack::role {
  class { '::openstack::profile::firewall': }
  class { '::openstack::profile::neutron::router': }
  class { '::openstack::setup::sharednetwork': }

  class { '::openstack::customize::network_upgrade': }
}
