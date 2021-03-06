Feature: Deck

@focus
Scenario: Dragging card to hand repeatedly
  Given I am on a new game page
    And my name is "Mr. Bombastic"

  When I grab first card from 'Library' in my panel
    And drag the card to my hand

  Then I should see the card in my hand

  When I drag the card to my hand
  Then I should see the card in my hand
