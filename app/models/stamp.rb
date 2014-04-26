require 'net/http'
require 'uri'


class Stamp < ActiveRecord::Base

  serialize :names, JSON

  scope :playable, -> { where(layout: [ 'normal', 'double-face' ]) }

  def self.[](name)
    find_by! name: name
  end

  def self.draw_hand
    playable.order('random()').limit(7)
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
