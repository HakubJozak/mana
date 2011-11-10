namespace :cards do
  namespace :tokens do

    desc 'Updates all token CardStamps'
    task :update => :environment do
      require 'rubygems'
      require 'mechanize'

      agent = Mechanize.new
      agent.get 'http://magiccards.info/extras.html'

      agent.page.links_with(href: /token/).each do |link|
        link.click
        name = link.text
        puts name

        stamp = CardStamp.tokens.find_or_initialize_by(name: name)
        stamp.token = true
        stamp.image_url = agent.page.images.find { |i| i.src =~ /token/ }.url
        stamp.save!
      end
    end

    desc 'Remove all tokens'
    task :clean => :environment do
      CardStamp.delete_all #(conditions: { token: true })
    end
  end
end
