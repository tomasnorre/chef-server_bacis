#
# Cookbook Name:: server_basic
# Recipe:: locales
#
# Copyright 2015, Tomas Norre Mikkelsen
#
# All rights reserved - Do Not Redistribute
#

bash 'set_locales' do
  user 'root'
  code <<-LOCALES
  locale-gen en_US.UTF-8
  LOCALES
end
