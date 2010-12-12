set :application, "mana"
set :repository, "git@github.com:HakubJozak/mana.git"
set :use_sudo, false
set :user, 'root'

# set :rvm_type, :user

set :scm, :git
set :deploy_to, "/root/#{application}_production"


role :app, "mana-edge"


namespace :deploy do
  task :shared_symlink do
    run "ln -s #{shared_path}/config/production.rb #{release_path}/config/production.rb"
  end

  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end


namespace :thin do  
  %w(start stop restart).each do |action| 
  desc "#{action} the app's Thin Cluster"  
    task action.to_sym, :roles => :app do  
      run "thin #{action} -c #{deploy_to}/current -C #{deploy_to}/current/config/thin.yml" 
    end
  end
end

after "deploy:finalize_update", "deploy:shared_symlink"
