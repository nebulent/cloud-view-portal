Given "I add a terminal" do
  @added_terminal = FactoryGirl.create :terminal

  steps %Q{
    Given I am on the terminals page
      And I click "Add terminal"
      And I fill in the following:
        | terminal_name  | #{@added_terminal.name}  |
        | terminal_uri   | #{@added_terminal.uri}   |
      And I press "Add terminal"
    Then I should be on terminals page
  }
end

Then "The terminal should be in the list" do
  steps %Q{
    Given I am on the terminals page
    Then I should see "#{@added_terminal.name}"
     And I should see "#{@added_terminal.uri}"
  }
end

Then "The terminal should not be in the list" do
  steps %Q{
    Given I am on the terminals page
    Then I should not see "#{@terminal_to_delete.name}"
     And I should not see "#{@terminal_to_delete.uri}"
  }
end

When "I delete one of the terminals" do
  @terminal_to_delete = @data_collection.sample
  index = @terminal_to_delete.id

  within("#terminal#{index}") do
    steps %Q{
      Given I press "Delete"
        And I get a confirm dialog
        And I confirm the dialog
    }
  end
end


Then "All terminals should be in the list" do
  step 'I am on the terminals page'

  @data_collection.each do |t|
    step "I should see \"#{t.name}\""
  end
end
