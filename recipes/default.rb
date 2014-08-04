#
# Cookbook Name:: server_basic
# Recipe:: default
#
# Copyright 2014, Tomas Norre Mikkelsen
#
# All rights reserved - Do Not Redistribute
#

include_recipe "git"

packages = %w(
  'htop'
  'sed'
  'vim'
  'wget'
)

packages.each do |pkg|
  package pkg do
    action :upgrade
  end
end
