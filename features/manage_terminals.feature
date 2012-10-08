Feature: Manage terminals

  Scenario: View terminals
    Given I have some random terminals
    Then I should see all terminals in the list

  Scenario: Add terminal
    Given I add a terminal
    Then The terminal should be in the list

  Scenario: Delete a terminal
    Given I have some terminals
      And I am on the terminals page
    When I delete one of the terminals
    Then The terminal should not be in the list

  Scenario: Edit a terminal
    Given I have some terminals
      And I edit on of them
     Then The updated terminal should be in the list
