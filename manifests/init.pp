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
  $provider            = $appfirst::params::provider
) inherits appfirst::params {

  package { $prereq:
    ensure => latest,
  }

  package { 'appfirst':
    ensure   => present,
    source   => $package_source,
    require  => Package[$prereq],
    provider => $provider
  }

  service { 'afcollector':
    ensure  => running,
    enable  => true,
    require => Package['appfirst'],
  }
}
