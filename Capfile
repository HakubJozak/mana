load 'deploy' if respond_to?(:namespace) # cap2 differentiator
# Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require 'rubygems'
require 'capistrano_colors'
require "rvm/capistrano"
require 'bundler/capistrano'
# require 'railsless-deploy'

set :rvm_ruby_string, "1.9.2-p290"
set :rvm_type, :user


load 'config/deploy'


# load 'deploy/assets'
