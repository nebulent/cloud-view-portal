Given "I add a terminal" do
  steps %q{
    Given I am on the terminals page
    And I click "Add terminal"
    And I fill in the following:
      | terminal_name  | t1                            |
      | terminal_uri   | vnc://alisnic@localhost:9292  |
    And I press "Add terminal"
    Then I should be on terminals page
  }
end

Then /^I should see it in terminals list$/ do
    pending # express the regexp above with the code you wish you had
end
