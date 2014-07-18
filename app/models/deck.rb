class Deck < ActiveRecord::Base

  has_one :player
  belongs_to :user
  validates_presence_of :name, :mainboard

  # BOARD_REGEXP = %r{\A(?:^\d+;.*$*)\z}
  # validates_format_of :mainboard, with: BOARD_REGEXP, message: 'has incorrect format'
  # validates_format_of :sideboard, with: BOARD_REGEXP, allow_nil: true

  LINE_REGEXP = /^(\d+);(.*)$/
  validate :parse_mainboard

  def parse_mainboard
    mainboard.each_line.with_index do |line,i|
      if match = line.match(/^(\d+);(.*)$/)
        _, count, name = match.to_a

        if stamp = Stamp.find_by_name(name.strip)
          count.to_i.times do
            yield if block_given?
          end
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
