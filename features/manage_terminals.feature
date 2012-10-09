Feature: Manage terminals

  Scenario: View terminals
    Given I have 3 terminals
    Then All terminals should be in the list

  Scenario: Add terminal
    Given I add a terminal
    Then The terminal should be in the list

  @javascript
  Scenario: Delete a terminal
    Given I have 3 terminals
      And I am on the terminals page
    When I delete one of the terminals
    Then The terminal should not be in the list

  Scenario: Edit a terminal
    Given I have 3 terminals
      And I am on the terminals page
      And I edit one of the terminals
     Then The terminal should be in the list
