require 'mtg_json_loader'

namespace :stamps do
  task :load => :environment do
    Stamp.delete_all
    MtgJsonLoader.load_all
  end

  desc 'Remove all stamps'
  task :delete => :environment do
    Stamp.delete_all
  end
end
