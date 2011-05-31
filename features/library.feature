Feature: Library

Scenario: Opening my Library
  Given I am on the some game page
    And my name is 'Player'
  When I 'Browse' the 'Library' in my panel
  Then I should see 'Library' window with 60 cards
    And I should not see 'Library' in my panel