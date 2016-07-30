#
# Cookbook Name:: server_basic
# Recipe:: yad
#
# Copyright 2016, Tomas Norre Mikkelsen
#
#

# Prepare directory
directory /etc/yad do
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

    # Check if production or integration environment
    if node['nodeinfo']['hostname'] == webhotel['prod_server']
      server = webhotel['prod_server']
      server_type = 'production'
      environments = ['production']
    else
      server = webhotel['int_server']
      server_type = 'integration'
      environments = webhotel['environments']
    end

    # If hostname and server is not the same, don't proceed
    if node['nodeinfo']['hostname'] == server

      yad_script = '/usr/local/bin/yad_' + webhotel['id'] + '_typo3_latest'
      # Create yad scripts
      template yad_script do
        source 'yad_project_type_environment.erb'
        owner 'root'
        group 'root'
        mode '0766'
        variables(
          project: webhotel['id'],
          type: 'typo3',
          environment: 'latest',
        )
      end

      # YAD Settings
      yad_settings_dir = '/etc/yad/' + webhotel['id'] + '/typo3/'
      yad_settings_file = yad_settings_dir + 'latest.sh'

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
          type: 'typo3',
          environment: 'latest',
        )
      end

    end
  end
end
