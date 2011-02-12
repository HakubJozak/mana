require 'rubygems'

require 'nokogiri'
require 'open-uri'


doc = Nokogiri::HTML(open('http://magiccards.info/extras.html'))

tokens = []

doc.css('td').each do |td|
  if td.content == 'Token'
    a = td.parent.css('td > a').first
    image = a.attribute('href').to_s.gsub(/extra/,'extras').gsub('html','jpg')
    tokens << " '#{a.content}' => '#{image}' "
  end
end

puts "TOKENS =  { #{tokens.join(",\n")} }"

