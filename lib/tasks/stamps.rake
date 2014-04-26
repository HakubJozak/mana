namespace :stamps do
  task :load => :environment do
    sets = File.read(Rails.root + 'db/AllSets-x.json')
  end

  desc 'Remove all stamps'
  task :delete => :environment do
    Stamp.delete_all
  end
end
