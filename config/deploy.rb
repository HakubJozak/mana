set :application, "mana"
set :use_sudo, false

set :user, 'ubuntu'

set :deploy_to, "/home/ubuntu/#{application}"
ssh_options[:keys] = [ './jakub.hozak.amazon.pem' ]


role :app, "ec2-176-34-195-147.eu-west-1.compute.amazonaws.com"
role :web, "ec2-176-34-195-147.eu-west-1.compute.amazonaws.com"

set :scm, :git
set :repository, "git@github.com:HakubJozak/mana.git"
set :scm_user, "git"
set :branch, 'master'




namespace :deploy do
  task :shared_symlink do
    [ 'pids' ].each do |path|
      run "ln -s #{shared_path}/#{path} #{release_path}/#{path}"
    end
  end
end

namespace :log do
  desc "Tails the thin log"
  task "thin" do
    run "tail -f #{shared_path}/log/thin.8080.log"
  end

  desc "Tails the production log"
  task "web" do
    run "tail -f #{shared_path}/log/production.log"
  end

  desc "Tails the production log"
  task "backend" do
#    run "tail -f #{shared_path}/log/production.log"
  end
end


namespace :backend do
end


namespace :thin do
  %w(start stop restart).each do |action|
    desc "#{action} the app's Thin Cluster"
    task action.to_sym, :roles => :app do
      run "cd #{current_path} && rvm use #{rvm_ruby_string} && bundle exec thin #{action} -c #{deploy_to}/current -C #{deploy_to}/current/config/thin.yml"
    end
  end
end

after "deploy:finalize_update", "deploy:shared_symlink"
after "deploy", 'thin:restart'
