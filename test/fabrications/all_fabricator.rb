Fabricator(:user) do
  name 'Bob Dole'
  email 'some@example.com'
  password 'cooler123'
end

Fabricator(:game) do
  name 'Awesome Game'
end

Fabricator(:deck) do
  name 'Highlander'
  mainboard %{
    1;Forest
    1;Mountain
    1;Island
    1;Swamp
    1;Plains
  }
end

Fabricator(:player) do
  deck
end

Fabricator(:game_with_players, :from => :game) do
  after_create do |game|
    game.players << Fabricate.build(:player, name: 'Player1')
    game.players << Fabricate.build(:player, name: 'Player2')
  end
end


Fabricator(:game_with_bad_cards, :from => :game) do
  cards = %{
    1;Forest*
    1;Mountain*
    1;Island*
    1;Swamp*
    1;Plains*
  }

  deck = Fabricate(:deck, mainboard: cards)

  after_create do |game|
    game.players << Fabricate.build(:player, name: 'Player1', deck: deck)
  end
end


