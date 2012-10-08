Feature: Manage terminals

  Scenario: View terminals
    Given I am on the terminals page
    Then I should see "Terminals:"

  Scenario: Add terminal
    Given I add a terminal
    Then I should see it in terminals list
