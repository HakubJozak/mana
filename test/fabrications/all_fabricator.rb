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
  %}
end

Fabricator(:player) do
  deck
end

Fabricator(:game_with_players, :from => :game) do
  after_create do |game|
    2.times do
      game.players << Fabricate.build(:player)
    end
  end
end


