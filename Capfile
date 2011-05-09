load 'deploy' if respond_to?(:namespace) # cap2 differentiator
# Dir['vendor/plugins/*/recipes/*.rb'].each { |plugin| load(plugin) }

# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

require 'rubygems'
require 'railsless-deploy'
require "rvm/capistrano"
require 'bundler/capistrano'

set :rvm_ruby_string, "1.9.2-p180"

load    'config/deploy'
