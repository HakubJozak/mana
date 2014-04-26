require 'net/http'
require 'uri'


class Stamp < ActiveRecord::Base

  def self.[](name)
    find_by! name: name
  end

  def double_faced?
    self.layout == 'double-faced'
  end

  private

  def backside_url
    if double_faced?
      'http'
    else
      nil
    end
  end

end
