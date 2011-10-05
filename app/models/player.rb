class Player
  include Mongoid::Document

  field :name, type: String
  field :deck, type: String
  field :color,type: String, default: '#FF0000'

  validates_presence_of :name

  embedded_in :game
  belongs_to :user

  after_initialize do
    if self.user
      self.name ||= self.user.name
    else
      # TODO: take it from cookie
      self.name ||= "Guest"
    end

    self.deck = File.open("#{Rails.root}/db/decks/eldrazi").read if defined?(Rails)
  end

  def to_hash(opts = {})
    @library = Library.new(self, deck)

    result = { :name => name, :id => id, :color => color }
    opts[:include_library] ? result.merge({ :cards => @library.cards }) : result
  end

  def connection=(ws)
    @connection = ws
  end

  def sid=(sid)
    @sid = sid
  end


  def message_to_client(scope, command)
    @connection.send(encode(command))
  end


end

