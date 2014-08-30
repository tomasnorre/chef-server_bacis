#
# Cookbook Name:: server_basic
# Recipe:: ntp
#
# Copyright 2014, Tomas Norre Mikkelsen
#
# All rights reserved - Do Not Redistribute
#

%w(ntp ntpdate).each do |pkg|
  package pkg
end

service 'ntp' do
  supports status: true, restart: true
  action [:enable, :start]
end

template '/etc/timezone' do
  source 'timezone.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

template '/etc/ntp.conf' do
  source 'ntp.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[ntp]', :immediately
end
