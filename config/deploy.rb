require 'bundler/capistrano'

set :application, "mana"
set :repository, "git@github.com:HakubJozak/mana.git"

set :scm, :git
set :deploy_to, "/home/root/#{application}"

role :web, "mana-edge"
role :app, "mana-edge"
role :db,  "mana-edge", :primary => true
role :db,  "mana-edge"

# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end


# namespace :thin do  
#   %w(start stop restart).each do |action| 
#   desc "#{action} the app's Thin Cluster"  
#     task action.to_sym, :roles => :app do  
#       run "thin #{action} -c #{deploy_to}/current -C #{deploy_to}/current/config/thin.yml" 
#     end
#   end
# end
