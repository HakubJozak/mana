Feature: Lobby

Scenario: Lobby page
  Given I am on the some game page
  When I press "Play" within the "Lobby" dialog
  Then I wait until "#left-panel" is visible

Scenario: QUnit tests
  Given I am on the some game page
  When I integrate QUnit
  When I run card and dropbox tests
  Then I wait 3 seconds
  Then I should not see any QUnit errors
  