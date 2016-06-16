# The profile to set up the endpoints, auth, and database for Glance
# Because of the include, api must come before auth if colocated
class openstack::profile::glance::auth {
  openstack::resources::controller { 'glance': }
  # check prerequisites

  openstack::resources::database { 'glance': }
  # call ::glance::db::mysql to create glance database in Mysql

  openstack::resources::firewall { 'Glance API': port      => '9292', }
  openstack::resources::firewall { 'Glance Registry': port => '9191', }

  class  { '::glance::keystone::auth':
  # create user，role,service and endpoints
    password         => $::openstack::config::glance_password,
    public_address   => $::openstack::config::storage_address_api,
    admin_address    => $::openstack::config::storage_address_management,
    internal_address => $::openstack::config::storage_address_management,
    region           => $::openstack::config::region,
  } 

  include ::openstack::common::glance
  # call ::glance::api to create glance-api configuration
  
}
