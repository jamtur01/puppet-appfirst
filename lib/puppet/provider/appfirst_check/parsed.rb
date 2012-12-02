require 'puppet/provider/parsedfile'

config = "/usr/share/appfirst/plugins/etc/nrpe_appfirst.cfg"
scripts_dir = "/usr/share/appfirst/plugins/libexec"

Puppet::Type.type(:appfirst_check).provide(:parsed,:parent => Puppet::Provider::ParsedFile,
  :default_target => config,:filetype => :flat) do
  confine :exists => config

  text_line :comment, :match => /^#/
  text_line :blank, :match => /^\s*$/

  record_line :parsed, :fields => %w{command name options warning critical},
    :optional => %w{options},
    :match    => /^command\[(.*)\]\=(.*)\s(.*)\s\-w\s(.*)\s\-c(.*)$/,
    :to_line  => proc { |hash|
      scripts_dir = hash[:scripts_dir] unless hash[:scripts_dir].nil? or hash[:scripts_dir] == :absent
      if hash[:options].nil? or hash[:options] == :absent
        options = ''
      else
        options = hash[:options]
      end
      str = "command[#{hash[:command]}]=#{scripts_dir}/#{hash[:name]} #{options} -w #{hash[:warning]} -c #{hash[:critical]}"
      str
    }
end
