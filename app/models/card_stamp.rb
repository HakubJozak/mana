require 'net/http'
require 'uri'


class CardStamp

  include Mongoid::Document

  field :name, type: String
  field :url, type: String
  field :image_url, type: String

  CARDS_REGEXP = Regexp.new("<p>([0-9])+ <a href=\"(.*)\" onmouse.*>(.*)</a></p>")
  IMAGE_REGEXP = Regexp.new("<img src=\".*(/scans/.*\.jpg)\".*")
  CARD_NAME_REGEXP = Regexp.new('<h1><a href=.*>(.*)</a>.*</h1>')

  def self.print_by_name(name, &block)
    stamp = where(name: name).first || fetch_stamp(name)
    stamp.print(&block)
  end

  def print(&block)
    Card.new( name: self.name,
              image_url: self.image_url,
              url: url) do |card|
      yield(card) if block
    end
  end

  def self.fetch_stamp(name)
    stamp = new(:name => name)
    stamp.url, page = goto_url(stamp_url(name))
    uri = page.scan(IMAGE_REGEXP)[0]

    if page && uri
      stamp.image_url = "http://magiccards.info" + uri[0]
      stamp.save!
      stamp
    else
      # TODO: inform about missing card
      nil
    end
  end

  private

  # TODO - limit number of redirects
  def self.goto_url(url)
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

  def self.stamp_url(name)
    "http://magiccards.info/query?q=!#{URI.escape(name)}&v=card&s=cname"
  end

end






