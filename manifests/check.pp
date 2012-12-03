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
#  appfirst::check { 'check_title':
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
define appfirst::check(
  $command             = '',
  $warning             = '',
  $critical            = '',
  $options             = '',
  $owner               = $appfirst::params::owner,
  $group               = $appfirst::params::group,
  $nrpe_config_dir     = $appfirst::params::nrpe_config_dir,
  $nrpe_scripts_dir    = $appfirst::params::nrpe_scripts_dir,
) {

  include appfirst
  include appfirst::params

  File {
    owner   => $owner,
    group   => $group,
  }

  file { "${nrpe_scripts_dir}/${title}":
    ensure  => present,
    source  => "puppet:///modules/appfirst/${title}",
    require => [ File[$nrpe_scripts_dir], File[$nrpe_config_dir] ],
    notify  => Service['afcollector'],
  }

  appfirst_check { $title:
    ensure      => present,
    command     => $command,
    options     => $options,
    warning     => $warning,
    critical    => $critical,
    require     => File["${nrpe_scripts_dir}/${title}"],
    notify      => Service['afcollector'],
  }
}
