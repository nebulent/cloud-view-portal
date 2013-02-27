Feature: Grant Temporary AWS access

  Scenario: Grant AWS access to users of the organization
    Given that I am an organization head
    And I am on the index on the dashboard
    And I click "AWS tokens"
    Then I should see "AWS tokens"

  Scenario: Create a new AWS token
    Given I create an AWS token
    And I assign it to the a user
    And I log out
    And I sign in as the user
    And I go to the tokens page
    Then I should see the token



