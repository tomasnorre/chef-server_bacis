#
# Cookbook Name:: server_basic
# Recipe:: default
#
# Copyright 2016, Tomas Norre Mikkelsen
#
#

include_recipe 'server_basic::ntp'
include_recipe 'server_basic::locales'
include_recipe 'server_basic::yad'
include_recipe 'server_basic::tomas'

packagespurge = %w[
  apparmor
  apparmor-utils
  libapparmor-perl
  libapparmor
  ubuntu-minimal
  command-not-found
  command-not-found-data
  landscape-common
]

packages = %w[
  htop
  sed
  vim
  wget
  git
  curl
  tree
  rsync
  zsh
  ruby-dev
  gcc
  mtr
]

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

template '/root/provision.txt' do
  source 'provision.txt.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
