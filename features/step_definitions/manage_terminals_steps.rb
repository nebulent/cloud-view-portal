Given "I add a terminal" do
  @new_terminal_name = SecureRandom.hex(10)
  login = SecureRandom.hex(5)
  host = SecureRandom.hex(8)
  @new_terminal_uri = "vnc://#{login}@#{host}:9292"

  steps %Q{
    Given I am on the terminals page
      And I click "Add terminal"
      And I fill in the following:
        | terminal_name  | #{@new_terminal_name}  |
        | terminal_uri   | #{@new_terminal_uri}   |
      And I press "Add terminal"
    Then I should be on terminals page
  }
end

Then "The terminal should be in the list" do
  steps %Q{
    Given I am on the terminals page
    Then I should see "#{@new_terminal_name}"
     And I should see "#{@new_terminal_uri}"
  }
end
