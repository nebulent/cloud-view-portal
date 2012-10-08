Given "I add a terminal" do
  step 'I am on the terminals page'
  step 'I click "Add terminal"'
  step 'I fill in the following:', table(%{
    | terminal_name  | t1                            |
    | terminal_uri   | vnc://alisnic@localhost:9292  |})
  step 'I press "Add terminal"'
  step 'I should be on terminals page'
end

Then /^I should see it in terminals list$/ do
    pending # express the regexp above with the code you wish you had
end
