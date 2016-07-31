#
# Cookbook Name:: server_basic
# Recipe:: yad
#
# Copyright 2016, Tomas Norre Mikkelsen
#
#

require 'json'

# Prepare directory
directory '/etc/yad' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

# Clone YAD - Yet Another Deployment-tool
git "YAD" do
  repository 'https://github.com/aoepeople/YAD.git'
  destination '/etc/yad/deploy/'
  action :sync
end

if defined? node['nodeinfo']['hostname'] && node['nodeinfo']['hostname']

  webhotels = data_bag('webhotels')
  webhotels.each do |identifier|

    webhotel = data_bag_item('webhotels', identifier)
    configuration = JSON.load(webhotel["configuration"].to_json)
    servers = configuration['servers']

    # Check if production or integration environment
    if node['nodeinfo']['hostname'] == servers['production']['hostname']
      server = configuration['servers']['production']['hostname']
      server_type = 'production'
    else
      server = servers['integration']['hostname']
      server_type = 'integration'
    end

    environments = servers[server_type]['environments']

    # If hostname and server is not the same, don't proceed
    if node['nodeinfo']['hostname'] == server

      environments.each do |(environment,config)|
        # Create yad scripts
        script_dir = '/usr/local/bin/'
        yad_script = script_dir + 'yad_' + webhotel['id'] + '_' + configuration['type'] + '_' + environment

        template yad_script do
          source 'yad_project_type_environment.erb'
          owner 'root'
          group 'root'
          mode '0766'
          variables(
            project: webhotel['id'],
            type: configuration['type'],
            environment: environment,
          )
        end

        # YAD Settings
        yad_settings_dir = '/etc/yad/' + webhotel['id'] + '/' + configuration['type'] + '/'
        yad_settings_file = yad_settings_dir + environment + '.sh'

        directory yad_settings_dir do
          owner 'root'
          group 'root'
          mode '0755'
          recursive true
          action :create
        end

        # Create yad scripts
        template yad_settings_file do
          source 'yad_settings.erb'
          owner 'root'
          group 'root'
          mode '0766'
          variables(
            project: webhotel['id'],
            domain: webhotel['domain'],
            type: configuration['type'],
            environment: environment,
            yad_package: configuration['yad_package'],
            yad_user: configuration['yad_user'],
            yad_pass: configuration['yad_pass']
          )
        end

      end

    end

  end

end
