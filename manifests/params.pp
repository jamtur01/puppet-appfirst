# == Class: appfirst::params
#
# Parameters for the AppFirst module
#
# === Authors
#
# Author Name <james@puppetlabs.com>
#
# === Copyright
#
# Copyright 2012 James Turnbull
#
class appfirst::params {

  $appfirst_id      = '5411'
  $owner            = 'root'
  $group            = 'root'
  $appfirst_dir     = '/usr/share/appfirst'
  $nrpe_config_dir  = "${appfirst_dir}/plugins/etc"
  $nrpe_config      = "${nrpe_config_dir}/nrpe_appfirst.cfg"
  $nrpe_scripts_dir = "${appfirst_dir}/plugins/libexec"

  case $::osfamily {
    'redhat', 'suse': {
      $prereq         = [ 'openssl098e', 'compat-openldap', 'perl' ]
      $package_source = "http://wwws.appfirst.com/packages/initial/${appfirst_id}/appfirst-${::architecture}.rpm"
      $provider       = 'rpm'
    }
    'debian': {
      $prereq         = [ 'libssl0.9.8' ]
      $package_source = "http://wwws.appfirst.com/packages/initial/${appfirst_id}/appfirst-${::architecture}.deb"
      $provider       = 'deb'
    }

    default: {
      fail("Unsupported OS family: ${::osfamily}")
    }
  }

}
