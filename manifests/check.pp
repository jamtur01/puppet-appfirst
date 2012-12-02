# == Class: appfirst::check
#
# Manages AppFirst checks
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
class appfirst::check(
  $nrpe_config_dir     = $appfirst::params::nrpe_config_dir,
  $nrpe_config         = $appfirst::params::nrpe_config,
  $nrpe_scripts_dir    = $appfirst::params::nrpe_scripts_dir,
  $nrpe_script         = $appfirst::params::nrpe_script,
  $appfirst_id         = $appfirst::params::appfirst_id,
  $owner               = $appfirst::params::owner,
  $group               = $appfirst::params::group,
) inherits appfirst::params {

  file { [ $nrpe_config_dir, $nrpe_scripts_dir ]:
    ensure => directory,
    owner  => $owner,
    group  => $group,
    mode   => '0755',
  }

  file { $nrpe_config:
    ensure => present,
    owner  => $owner,
    group  => $group,
  }

  file { "${nrpe_scripts_dir}/${nrpe_script}":
    ensure  => present,
    source  => '',
    require => [ File[$nrpe_scripts_dir], File[$nrpe_config] ],
    notify  => Service['afcollector'],
  }

  exec { "echo 'command[#{new_resource.command}]=#{nrpe_scripts_dir}/#{new_resource.script_name} #{new_resource.options} -w #{new_resource.warning} -c #{new_resource.critical}' >> #{nrpe_config}":
    notify  => Service['afcollector'],
    onlyif  => "cat #{nrpe_config} | grep -- #{new_resource.script_name}",
  } ## ParsedFile type?

}
