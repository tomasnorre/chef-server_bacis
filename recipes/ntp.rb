#
# Cookbook Name:: server_basic
# Recipe:: ntp
#
# Copyright 2015, Tomas Norre Mikkelsen
#
# All rights reserved - Do Not Redistribute
#

%w[ntp ntpdate tzdata].each do |pkg|
  package pkg do
    action :install
  end
end

# Setting variables
timezone = if node['nodeinfo']['timezone']
             node['nodeinfo']['timezone']
           else
             'Europe/Copenhagen'
           end

service 'ntp' do
  supports status: true, restart: true
  action %i[enable start]
end

template '/etc/timezone' do
  source 'timezone.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(
    timezone: timezone
  )
end

template '/etc/ntp.conf' do
  source 'ntp.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[ntp]', :immediately
end
