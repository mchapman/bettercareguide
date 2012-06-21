Given /^I am not authenticated$/ do
  visit('/users/sign_out') 
end

Given /^the following user records$/ do |table|
  begin
    table.hashes.each do |hash|
      User.make!(hash)
    end
  rescue Exception
    # it has already been done
  end
end

Given /^I am an? (.*) user$/ do |user_type|
  steps %Q{
  Given I am not authenticated
  And I go to login
  And I fill in "Email" with "#{user_type}@example.com"
  And I fill in "Password" with "secret"
  And I press "Log In"
  Then I should see "Signed in successfully"
  }
end

