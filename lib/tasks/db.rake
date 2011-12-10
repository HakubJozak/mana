namespace :db do

  desc 'Restore mongo db from data.tar.gz'
  task :restore do
    system 'cd db && tar -zxvf ./data.tar.gz && mongorestore ./dump && rm -rfv ./dump'
  end

end
