Given "I add a terminal" do
  @terminal = FactoryGirl.create :terminal

  steps %Q{
    Given I am on the terminals page
      And I click "Add terminal"
      And I fill in the following:
        | terminal_name  | #{@terminal.name}  |
        | terminal_uri   | #{@terminal.uri}   |
      And I press "Add terminal"
    Then I should be on terminals page
  }
end

Then "The terminal should be in the list" do
  steps %Q{
    Given I am on the terminals page
    Then I should see "#{@terminal.name}"
     And I should see "#{@terminal.uri}"
  }
end

Then "The terminal should not be in the list" do
  steps %Q{
    Given I am on the terminals page
    Then I should not see "#{@terminal.name}"
     And I should not see "#{@terminal.uri}"
  }
end

When "I delete one of the terminals" do
  @terminal = @data_collection.sample
  index = @terminal.id

  within("#terminal#{index}") do
    steps %Q{
      Given I press "Delete"
        And I get a confirm dialog
        And I confirm the dialog
    }
  end
end

When "I edit one of the terminals" do
  @terminal = @data_collection.sample
  index = @terminal.id

  @updated_terminal = FactoryGirl.build :terminal

  steps %Q{
    Given I click "Edit"
    And I fill in the following:
      | terminal_name  | #{@updated_terminal.name}  |
      | terminal_uri   | #{@updated_terminal.uri}   |
    And I press "Update"
  }
end

Then "All terminals should be in the list" do
  step 'I am on the terminals page'

  @data_collection.each do |t|
    step "I should see \"#{t.name}\""
  end
end
