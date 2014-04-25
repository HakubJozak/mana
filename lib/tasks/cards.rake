namespace :stamps do
  task :fetch => :environment do
      ['Forest',
       'Mountain',
       'Plains',
       'Swamp',
       'Cloistered Youth',
       'Emrakul, the Aeons Torn',
       'Explore',
       'Eye of Ugin',
       'Forest',
       'Harrow',
       'Joraga Treespeaker',
       'Khalni Heart Expedition',
       'Koth of the Hammer',
       'Kozilek, Butcher of Truth',
       'Lightning Bolt',
       'Mountain',
       'Mystifying Maze',
       'Oracle of Mul Daya',
       'Primeval Titan',
       'Summoning Trap',
       'Terramorphic Expanse',
       'Ulamog, the Infinite Gyre',
       'Valakut, the Molten Pinnacle'].each do |name|
      Stamp.fetch!(name)
      putc '.'
    end
  end

  # desc 'Updates all token CardStamps'
  # task :tokens => :environment do
  #   require 'rubygems'
  #   require 'mechanize'

  #   agent = Mechanize.new
  #   agent.get 'http://magiccards.info/extras.html'

  #   agent.page.links_with(href: /token/).each do |link|
  #     link.click
  #     name = link.text
  #     puts name

  #     stamp = Stamp.tokens.find_or_initialize_by(name: name)
  #     stamp.token = true
  #     stamp.image_url = agent.page.images.find { |i| i.src =~ /token/ }.url
  #     stamp.save!
  #   end
  # end

  desc 'Remove all tokens'
  task :delete => :environment do
    Stamp.delete_all #(conditions: { token: true })
  end
end
