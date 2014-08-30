#
# Cookbook Name:: server_basic
# Recipe:: hostname
#
# Copyright 2014, Tomas Norre Mikkelsen
#
# All rights reserved - Do Not Redistribute
#

if defined? node['nodeinfo']['hostname'] && node['nodeinfo']['hostname']
  bash "insert_line" do
    user "root"
    code <<-EOS
    echo node['nodeinfo']['hostname'] >> /etc/hostname
    EOS
  end
end
