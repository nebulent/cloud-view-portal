Feature: Grant Temporary AWS access

  Scenario: Grant AWS access to users of the organization
    Given that I am an organization head
    And I am on the index on the dashboard
    And I click "AWS tokens"
    Then I should be on the AWS access tokens page

