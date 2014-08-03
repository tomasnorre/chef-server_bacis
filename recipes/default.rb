#
# Cookbook Name:: server_basic
# Recipe:: default
#
# Copyright 2014, Tomas Norre Mikkelsen
#
# All rights reserved - Do Not Redistribute
#

packages=[
	'htop',
  'vim'
]

packages.each do |pkg|
	package pkg do
		action :upgrade
	end
end
