module Puppet
  newtype(:appfirst_check) do
    ensurable

    newparam(:name) do
      isnamevar
    end

    newproperty(:command) do
      desc "The command the check will execute."
    end

    newproperty(:warning) do
      desc "The warning threshold."
    end

    newproperty(:critical) do
      desc "The critical threshold."
    end

    newproperty(:options) do
      desc "Any options to pass to the check."
    end

    newproperty(:target) do
      desc "The file in which to write the check too. Defaults to `/usr/share/appfirst/plugins/etc/nrpe_appfirst.cfg`."

      defaultto "/usr/share/appfirst/plugins/etc/nrpe_appfirst.cfg"
    end

    @doc = "Installs and manages Appfirst NRPE-style checks."
  end
end
