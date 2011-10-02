class Game
  include Mongoid::Document

  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false

  field :name, :type => String
  field :created_at, :type => DateTime, :default => Time.now

  after_initialize do
    @users = []
    @channel = EM::Channel.new
  end


  #  embeds_many :users
  attr_reader :users

  # rename or not use at all!
  def self.find_or_create(id)
    Game.find(id)
  end


  def connect(user)
    user.sid = @channel.subscribe do |pack|
      # TODO: subclass EM::Channel to do this
      user.message_to_client(pack[:scope], pack[:command])
    end

    # add all others to new user
    @users.each do |remote_user|
      args = { :user => remote_user.to_hash(:include_library => true) }
      user.message_to_client(:all, args)
    end

    # add new user to new user
    # TODO: replace :local with requestID
    args = { :user => user.to_hash(:include_library => true).merge(:local => true)  };
    user.message_to_client(:me, args)

    # add new user to all others
    @users.each do |remote_user|
      args = { :user => user.to_hash(:include_library => true) };
      remote_user.message_to_client(:opponents, args)
    end

    @users << user
  end

  def send_to_opponents(command)
    broadcast_to :opponents, command
  end

  def disconnect(user)
    @users.delete(user)
    @channel.unsubscribe(user.sid)
    # TODO - send just ID and type
    # broadcast_to :opponents, user.to_hash
  end

  private

  # def add_user(user, args)
  #   server_command(:add_user, user, :args => args)
  # end

  # def remove_user(user)
  #   server_command(:remove_user, user, :args => { :user => user.to_hash })
  # end

  # TODO: subclass EM::Channel to do this
  def broadcast_to(scope, command)
    @channel.push(:scope => scope, :command => command)
  end

  def self.create(id)
    @@games[id] = Game.new(id)
  end

  # def server_command(operation, user, args = {})
  #   { :action => 'Server',
  #     :operation => operation.to_s,
  #     :sid => user.sid,
  #     :user => user.to_hash }.merge(args)
  # end

end
