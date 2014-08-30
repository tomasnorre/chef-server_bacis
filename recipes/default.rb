#
# Cookbook Name:: server_basic
# Recipe:: default
#
# Copyright 2014, Tomas Norre Mikkelsen
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'server_basic::ntp'

packagespurge = %w(
  'apparmor'
  'apparmor-utils'
  'libapparmor-perl'
  'libapparmor1'
  'ubuntu-minimal'
  'command-not-found'
  'command-not-found-data'
  'landscape-common'
)

packages = %w(
  'htop'
  'sed'
  'vim'
  'wget'
  'git'
)

case node['platform']
when 'debian', 'ubuntu'
  packagespurge.each do |pkg|
    package pkg do
      action :remove
    end
  end
  packages.each do |pkg|
    package pkg do
      action :upgrade
    end
  end
end
