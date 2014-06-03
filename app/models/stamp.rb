require 'net/http'
require 'uri'


class Stamp < ActiveRecord::Base

  serialize :names, JSON

  # not tokens and other garbage
  scope :playable, -> { where(layout: [ 'normal', 'double-face' ]) }

  def self.[](name)
    find_by! name: name
  end

  def self.draw_hand
    playable.random(7)
  end

  def self.random(count = 1)
    stamps = playable.order('random()').limit(count)
    count == 1 ? stamps.first : stamps
  end

  def double_faced?
    self.layout == 'double-faced'
  end

  def frontside_url
    "http://mtgimage.com/multiverseid/#{self.multiverseid}.jpg"
  end

  def backside_url
    if double_faced?
      the_dark_side = JSON.parse(self.names).reject { |n| n == name }.first
      Stamp[the_dark_side].frontside_url
    else
      nil
    end
  end

end
