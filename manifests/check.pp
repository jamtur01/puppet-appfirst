# == Class: appfirst::check
#
# Manages AppFirst checks
#
# === Parameters
#
# Document parameters here.
#
# === Examples
#
#  class { appfirst::check:
#    appfirst_id => '123456'
#  }
#
# === Authors
#
# Author Name <james@puppetlabs.com>
#
# === Copyright
#
# Copyright 2012 James Turnbull
#
class appfirst::check(
  $appfirst_dir        = $appfirst::params::appfirst_dir, 
  $nrpe_config_dir     = $appfirst::params::nrpe_config_dir,
  $nrpe_config         = $appfirst::params::nrpe_config,
  $nrpe_scripts_dir    = $appfirst::params::nrpe_scripts_dir,
  $owner               = $appfirst::params::owner,
  $group               = $appfirst::params::group,
  $command,
  $warning,
  $critical,
  $options,
  $nrpe_script,
) inherits appfirst::params {

  include appfirst

  File {
    owner   => $owner,
    group   => $group,
  }

  file { $appfirst_dir:
    ensure  => directory,
    mode    => '0755',
  }

  file { "${appfirst_dir}/plugins":
    ensure  => directory,
    mode    => '0755',
    require => File[$appfirst_dir],
  }

  file { [ $nrpe_config_dir, $nrpe_scripts_dir ]:
    ensure  => directory,
    mode    => '0755',
    require => File["${appfirst_dir}/plugins"],
  }

  file { $nrpe_config:
    ensure => present,
  }

  file { "${nrpe_scripts_dir}/${nrpe_script}":
    ensure  => present,
    source  => "puppet:///modules/appfirst/${nrpe_script}",
    require => [ File[$nrpe_scripts_dir], File[$nrpe_config_dir] ],
    notify  => Service['afcollector'],
  }

  appfirst_check { $nrpe_script:
    ensure      => present,
    command     => $command,
    options     => $options,
    warning     => $warning,
    critical    => $critical,
    require     => File["${nrpe_scripts_dir}/${nrpe_script}"],
    notify      => Service['afcollector'],
  }
}
