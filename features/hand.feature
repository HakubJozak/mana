Feature: Deck

Scenario: Dragging card to deck
  Given I am on the some game page playing
  When I integrate QUnit
  When I run hand integration test
  Then I wait 3 seconds
  Then I should not see any QUnit errors
