Feature: Lobby

Background:
  Given I am on a new game page

Scenario: Lobby page
  When I press "Play" within the "Lobby" dialog
  Then I wait until "#left-panel" is visible
