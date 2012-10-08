Given "I add a terminal" do
  @terminal_name = SecureRandom.hex(10)
  login = SecureRandom.hex(5)
  host = SecureRandom.hex(8)
  @terminal_uri = "vnc://#{login}@#{host}:9292"

  steps %Q{
    Given I am on the terminals page
      And I click "Add terminal"
      And I fill in the following:
        | terminal_name  | #{@terminal_name}  |
        | terminal_uri   | #{@terminal_uri}   |
      And I press "Add terminal"
    Then I should be on terminals page
  }
end

Then "The terminal should be in the list" do
  steps %Q{
    Given I am on the terminals page
    Then I should see "#{@terminal_name}"
     And I should see "#{@terminal_uri}"
  }
end

Then "The terminal should not be in the list" do
  page.driver.render "tmp/screenshot.png"
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

Given "I get a confirm dialog" do
  page.driver.confirm_messages.size > 0
end

Given "I confirm the dialog" do
  page.driver.accept_js_confirms!
end
