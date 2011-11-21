Fabricator(:user) do
  name 'Bob Dole'
  email 'some@example.com'
  password 'cooler123'
end

Fabricator(:game) do
  name 'Awesome Game'
end

Fabricator(:player) do
  game
end

