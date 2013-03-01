Given /^I create an AWS token$/ do
  @token = FactoryGirl.build :token
  steps %Q{
    Given that I am an organization head
      And I am on the index on the dashboard
      And I click "Add token"
      And I fill in the following:
        | active_at | #{@token.active_at} |
        | period    | #{@token.period}    |
      And I press "Add token"
  }
end

