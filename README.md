# puppet-appfirst

## Description

This module installs the AppFirst collector service and adds a type and
provider to manage AppFirst's NRPE-style checks.

## Requirements

* Puppet 2.6.5 or later
* An [AppFirst](https://wwws.appfirst.com/) account

## Installation

1.  Install puppet-appfirst as a module in your Puppet master's module
    path.

## Usage

To install the AppFirst collector declare the `appfirst` class.

    class { 'appfirst':
      appfirst_id => '123456',
    }

### Type and Provider

1.  To use the `appfirst_check` type enable pluginsync
    on your master and clients in `puppet.conf`

        [master]
        pluginsync = true
        [agent]
        pluginsync = true

2.  Run the Puppet client and sync the type and provider as a plugin

3.  You can then use the type and provider like so:

        appfirst_check { 'command':
          ensure      => present,
        }

Author
------

James Turnbull <james@lovedthanlost.net>

License
-------

    Author:: James Turnbull (<james@lovedthanlost.net>)
    Copyright:: Copyright (c) 2012 James Turnbull
    License:: Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
