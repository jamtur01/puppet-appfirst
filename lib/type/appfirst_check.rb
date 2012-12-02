module Puppet
  newtype(:appfirst_check) do
    ensurable

    newproperty(:command) do
      desc "The command the check will execute."

      isnamevar
    end

    newproperty(:script_name) do
      desc "The name of the script, for example 'check_nagios_process', alphanumeric plus - and _ only."
    end

    newproperty(:warning) do
      desc "The warning threshold."
    end

    newproperty(:critical) do
      desc "The critical threshold."
    end

    newproperty(:scripts_dir) do
      desc "The location of your AppFirst scripts. Defaults to `/usr/share/appfirst/plugins/libexec`. Optional."
    end

    newproperty(:target) do
      desc "The file in which to write the check too. Defaults to `/usr/share/appfirst/plugins/etc/nrpe_appfirst.cfg`."

      defaultto { if @resource.class.defaultprovider.ancestors.include?(Puppet::Provider::ParsedFile)
        @resource.class.defaultprovider.default_target
        else
          nil
        end
      }
    end

    @doc = "Installs and manages Appfirst NRPE-style checks."
  end
end
