Feature: Deck

Scenario: Dragging card to deck
  Given I am on a new game page
    And I integrate QUnit
    And I run hand integration test
    And I wait 3 seconds
    Then show me the page
   Then I should not see any QUnit errors
