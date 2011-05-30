Feature: Lobby

Scenario: Lobby page
  Given I am on the some game page
  When I press "Play" within the "Lobby" dialog
  Then I wait until "#left-panel" is visible