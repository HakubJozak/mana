require 'net/http'
require 'uri'


class MagicCardsInfo
  
  CARDS_REGEXP = Regexp.new("<p>([0-9])+ <a href=\"(.*)\" onmouse.*>(.*)</a></p>")
  IMAGE_REGEXP = Regexp.new("<img src=\".*(/scans/.*\.jpg)\".*")
  CARD_NAME_REGEXP = Regexp.new('<h1><a href=.*>(.*)</a>.*</h1>')

  def self.instance=(val)
    @@singleton = val
  end
  
  def self.instance
    @@singleton
  end
  
  def initialize(db)
    @db = db['cards']
  end
  
  def find_or_create_card(name)
    find_card(name) || create_card(name)
  end

  private

  def find_card(name)
    hash = @db.find_one(:name => name)
    hash.nil? ? nil : Card.new(hash)
  end
  
  def create_card(name)
    card = Card.new(:name => name)
    card.url, page = goto_url(card_url(name))
    card.image_url = "http://magiccards.info" + page.scan(IMAGE_REGEXP)[0][0]
    @db.insert(card.to_hash)
    card
  end

  # TODO - limit number of redirects
  def goto_url(url)
    response = Net::HTTP.get_response(URI.parse(url))
    status = response.code.to_i
    
    if status >= 300 and status < 400
      url = response['Location']
      # TODO - put general url beggining instead
      url = "http://magiccards.info" + url unless url.start_with?('http://')
      goto_url(url)
    else
      return url, response.body
    end
  end
  
  def card_url(name)
    "http://magiccards.info/query?q=!#{URI.escape(name)}&v=card&s=cname"
  end

end






