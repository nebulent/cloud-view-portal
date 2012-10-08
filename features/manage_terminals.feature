Feature: Manage terminals

  Scenario: View terminals
    Given I am on the terminals page
    Then I should see "Terminals:"

  Scenario: Add terminal
    Given I add a terminal
    Then The terminal should be in the list

  Scenario: Delete a terminal
    Given I have some random terminals
      And I am on the terminals page
    When I delete one of the terminals
    Then The terminal should not be in the list

  Scenario: Edit a terminal
    Given I have some random terminals
      And I edit on of them
     Then The updated terminal should be in the list
