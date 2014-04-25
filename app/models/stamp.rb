require 'net/http'
require 'uri'


class Stamp < ActiveRecord::Base

  IMAGE_REGEXP = Regexp.new("<img src=\".*(/scans/.*\.jpg)\".*")
  #  BBCode: [url=http://magiccards.info/isd/en/8a.html]Cloistered Youth[/url]
  REAL_URL_REGEXP = /\[url=(.*?)\]/

  class UnknownCard < Exception ; end


  # Either by name or exact URL.
  #
  def self.fetch!(name)
    stamp = Stamp.new(:name => name)
    page = goto_url("http://magiccards.info/query?q=!#{URI.escape(name)}&v=card&s=cname")

    stamp.url = page.scan(REAL_URL_REGEXP)[0][0] rescue nil
    raise UnknownCard.new(name) unless stamp.url

    uri = page.scan(IMAGE_REGEXP)[0][0] rescue nil
    raise UnknownCard.new(name) unless uri
    stamp.frontside = "http://magiccards.info" + uri

    # Guess backside if the card is double-sided.
    #
    # http://magiccards.info/isd/en/8a.html
    # http://magiccards.info/isd/en/8b.html
    #
    if stamp.has_backside?
      stamp.backside = stamp.frontside.gsub(/a\.jpg$/, 'b.jpg')
    end

    stamp.save!
    stamp
  end

  def has_backside?
    self.url.end_with?('a.html')
  end

  private

  def backside_url
    if has_backside?
      stamp.url.gsub(/a\.html$/, 'b.html')
    end
  end

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
