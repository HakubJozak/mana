set :application, "mana"
set :use_sudo, false

set :domain, "ec2-176-34-195-147.eu-west-1.compute.amazonaws.com"
set :user, 'ubuntu'

set :deploy_to, "/home/ubuntu/#{application}"
ssh_options[:keys] = [ './jakub.hozak.amazon.pem' ]

role :app, domain
role :web, domain

set :scm, :git
set :repository, "git@github.com:HakubJozak/mana.git"
set :scm_user, "git"
set :branch, 'master'



namespace :log do
  %w(unicorn production backend god).each do |type|
    desc "Tails log of #{type}"
    task type.to_sym do
      case type
        when 'god' then '/var/log/syslog'
        when 'nginx' then ''
      end

      file ||= "#{shared_path}/log/#{type}.log"
      run "tail -f #{file}"
    end
  end
end


bundle = "cd #{current_path} && rvm use #{rvm_ruby_string} && bundle exec "

namespace :god do
  desc 'Start God'
  task :start do
    run "#{bundle} god start -c #{current_path}/mana.god"
    run "tail /var/log/syslog"
  end

  desc 'Stop God'
  task :stop do
    run "#{bundle} god terminate"
  end
end


namespace :mongo do
  desc 'Start God'
  task :dump do
    run "cd #{shared_path} && mongodump -h localhost -d mana_production && tar -zcf data.tar.gz ./dump"
    get "#{shared_path}/data.tar.gz", "db/data.tar.gz"
    run "rm -rf #{shared_path}/dump && rm #{shared_path}/data.tar.gz"
  end
end


namespace :backend do
  %w(start stop restart status).each do |action|
    desc "#{action} backend"
    task action.to_sym, :roles => :app do
      run "#{bundle} god #{action} mana"
    end
  end
end


# namespace :thin do
#   %w(start stop restart).each do |action|
#     desc "#{action} the app's Thin Cluster"
#     task action.to_sym, :roles => :app do
#       run "cd #{current_path} && rvm use #{rvm_ruby_string} && bundle exec thin #{action} -P #{shared_path}/pids/thin.pid -C #{current_path}/config/thin.yml"
#     end
#   end
# end


set :rails_env, :production
set :unicorn_binary, "bundle exec unicorn"
set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

namespace :unicorn do
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && #{try_sudo} #{unicorn_binary} -c #{unicorn_config} -E #{rails_env} -D"
  end
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill `cat #{unicorn_pid}`"
  end
  task :graceful_stop, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
  end
  task :reload, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
  end
  task :restart, :roles => :app, :except => { :no_release => true } do
    stop
    start
  end
end


# after 'deploy:update_code', "deploy:shared_symlink"
# after "deploy", 'thin:restart'
# after "deploy", 'backend:restart'
