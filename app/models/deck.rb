class Deck < ActiveRecord::Base

  belongs_to :user
  validates_presence_of :name, :mainboard

  # BOARD_REGEXP = %r{\A(?:^\d+;.*$*)\z}
  # validates_format_of :mainboard, with: BOARD_REGEXP, message: 'has incorrect format'
  # validates_format_of :sideboard, with: BOARD_REGEXP, allow_nil: true


  LINE_REGEXP = /^(\d+);(.*)$/
  validate :mainboard_format

  def mainboard_format
    mainboard.each_line.with_index do |line,i|
      if match = line.match(/^(\d+);(.*)$/)
        _, count, name = match.to_a

        if stamp = Stamp.find_by_name(name.strip)
          # count.to_i.times do
            # cards.create! stamp: stamp,
            #               slot: self, position: i, covered: true,
            #               game: player.game, player: player
          # end
        else
          errors.add :mainboard, "card '#{name}' is unknown"
          false
        end
      else
        errors.add :mainboard, "wrong line: '#{line.strip}'"
      end
    end
  end
end
