# == Class: appfirst
#
# Installs the AppFirst collector
#
# === Parameters
#
# Document parameters here.
#
# [*appfirst_id*]
#   Your AppFirst ID, for example 123456. This is a required parameter.
#
# [*prereq*]
#   The prerequisite packages required to install the collector. Optional.
#
# [*package_source*]
#   The AppFirst team use a constructed URL to deliver packages. Optional.
#
# === Examples
#
#  class { appfirst:
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
class appfirst(
  $appfirst_id         = $appfirst::params::appfirst_id,
  $prereq              = $appfirst::params::prereq,
  $package_source      = $appfirst::params::package_source,
  $provider            = $appfirst::params::provider,
  $appfirst_dir        = $appfirst::params::appfirst_dir,
  $nrpe_config_dir     = $appfirst::params::nrpe_config_dir,
  $nrpe_config         = $appfirst::params::nrpe_config,
  $nrpe_scripts_dir    = $appfirst::params::nrpe_scripts_dir,
  $owner               = $appfirst::params::owner,
  $group               = $appfirst::params::group,
) inherits appfirst::params {

  File {
    owner   => $owner,
    group   => $group,
  }

  package { $prereq:
    ensure => latest,
  }

  package { 'appfirst':
    ensure   => present,
    source   => $package_source,
    require  => Package[$prereq],
    provider => $provider
  }

  file { $appfirst_dir:
    ensure  => directory,
    mode    => '0755',
    require => Package['appfirst']
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

  service { 'afcollector':
    ensure  => running,
    enable  => true,
    require => [ Package['appfirst'], File[$appfirst_dir] ],
  }
}
