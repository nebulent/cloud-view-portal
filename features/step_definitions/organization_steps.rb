Given /^that I am an organization head$/ do
  org = Organization.create!(:name => 'testorg')

  email = 'testing@man.net'
  password = 'secretpass'
  head = Head.create!(:email => email, :password => password, :password_confirmation => password)
  head.organizations << org

  visit '/organization/sign_in'
  fill_in "head_email", :with => email
  fill_in "head_password", :with => password
  click_button "Sign in"
end



