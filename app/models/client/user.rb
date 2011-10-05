module Mana
  class User

    attr_accessor :sid, :library
    attr_reader :ws, :name

    alias :id :sid

    def initialize(ws, player)
      @ws = ws
      @name = player.name
      @color = player.color
      update_library(player.deck)
    end

    def update_library(cards)

    end

  end
end
