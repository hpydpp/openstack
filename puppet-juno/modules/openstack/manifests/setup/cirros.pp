class openstack::setup::cirros {

  file { '/tmp/cirros-0.3.4-x86_64-disk.img':
    source => 'puppet:///modules/openstack/cirros-0.3.4-x86_64-disk.img'
  } ->

  glance_image { 'Cirros':
    ensure           => present,
    name             => 'Cirros',
    is_public        => 'yes',
    container_format => 'bare',
    disk_format      => 'qcow2',
    #source           => 'http://download.cirros-cloud.net/0.3.1/cirros-0.3.1-x86_64-disk.img',
    source           => '/tmp/cirros-0.3.4-x86_64-disk.img',
  }
}
