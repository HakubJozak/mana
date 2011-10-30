require 'net/http'
require 'uri'


class CardStamp

  include Mongoid::Document

  field :name, type: String
  field :url, type: String
  field :image_url, type: String
  field :counter, type: Integer, default: lambda { Mongoid.database.eval('next_counter()').to_i }

  has_one :backside, class_name: 'CardStamp'

  IMAGE_REGEXP = Regexp.new("<img src=\".*(/scans/.*\.jpg)\".*")

  #  BBCode: [url=http://magiccards.info/isd/en/8a.html]Cloistered Youth[/url]
  REAL_URL_REGEXP = /\[url=(.*?)\]/

  def self.print_by_name(name, &block)
    stamp = where(name: name).first || fetch(name)
    stamp && stamp.imprint(&block)
  end

  # Either by name or direct and exact URL.
  #
  def self.fetch(name)
    stamp = CardStamp.new(:name => name)

    page = goto_url("http://magiccards.info/query?q=!#{URI.escape(name)}&v=card&s=cname")

    stamp.url = page.scan(REAL_URL_REGEXP)[0][0] rescue nil
    return nil unless stamp.url

    uri = page.scan(IMAGE_REGEXP)[0][0] rescue nil
    return nil unless uri
    stamp.image_url = "http://magiccards.info" + uri

    # Guess backside if the card is double-sided.
    #
    # http://magiccards.info/isd/en/8b.html
    #
    if stamp.url.end_with?('a.html')
      # TODO - the name is wrong!
      back = CardStamp.create do |b|
        b.name = name
        b.url = stamp.url.gsub /a\.html$/, 'b.html'
        b.image_url = stamp.image_url.gsub /a\.jpg$/, 'b.jpg'
      end

      stamp.backside = back
    end

    stamp.save!
    stamp
  end

  def self.random(count = 1)
    max = CardStamp.count
    randoms = count.times.map { Random.rand(max) }

    #  HACK: returning first card in case none is found is wrong but
    #  enough for our dumb random search
    # TODO: in 1 query
    # any_in(counter: randoms)
    randoms.map { |rnd| where(counter: rnd).first || all.first }
  end

  def imprint(&block)
    Card.new( name: self.name,
              image_url: self.image_url,
              backside: self.backside,
              url: url) do |card|
      yield(card) if block
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
      return response.body
    end
  end



end






