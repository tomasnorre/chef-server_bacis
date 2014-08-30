#
# Cookbook Name:: server_basic
# Recipe:: hostname
#
# Copyright 2014, Tomas Norre Mikkelsen
#
# All rights reserved - Do Not Redistribute
#

bash 'update host file' do
  user 'root'
  code <<-EOS
  echo 127.0.0.1 #{node['nodeinfo']['hostname']} >> /etc/hosts
  EOS
  not_if "grep -q #{node['nodeinfo']['hostname']} /etc/hosts"
end

bash "set hostname" do
  only_if { node['nodeinfo']['hostname'] }
  user "root"
  code <<-EOS
  echo #{node['nodeinfo']['hostname']} > /etc/hostname
  service hostname restart
  EOS
end
