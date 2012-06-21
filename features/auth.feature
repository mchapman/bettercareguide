Feature: Authentication functions
  In order to ensure data is seen and updated by the correct people
  As an author of the site
  I want to provide log in / out / registration capabilities

Background:
# If you add anything to the background add it to all_backgrounds.txt as well
  Given the following users exist
    | email                  | password | roles_mask | accepted_t_and_cs |
    | normal@example.com     | secret   | 0          | 1                 |
    | admin@example.com      | secret   | 1          | 1                 |
    | reallycare@example.com | secret   | 2          | 1                 |

@allow-rescue

    Scenario: Create New Account
        Given I am not authenticated
        When I go to register
        And I fill in "user_email" with "bill@example.com"
        And I fill in "user_password" with "please"
        And I fill in "user_password_confirmation" with "please"
        And I press "Register"
        Then I should see "Terms and conditions must be accepted"
        And I check "user_accepted_t_and_cs"
        And I fill in "user_password" with "please"
        And I fill in "user_password_confirmation" with "please"
        And I press "Register"
        Then "bill@example.com" should receive an email
        And I open the email
        And I should see "Confirm my account" in the email body
        When I follow "Confirm my account" in the email
        Then I should see "Your account was successfully confirmed. You are now signed in."

    Scenario: Log in as an admin user
        And I am not authenticated
        When I go to sign in
        And I fill in "Email" with "admin@example.com"
        And I fill in "Password" with "secret"
        And I press "Log In"
        Then I should see "Signed in successfully"

    Scenario: Cannot log in as an admin user with incorrect password
        Given I am not authenticated
        When I go to sign in
        And I fill in "Email" with "admin@example.com"
        And I fill in "Password" with "incorrect"
        And I press "Log In"
        Then I should not see "Signed in successfully"

    Scenario: A normal user can access the change password page
        Given I am a normal user
        When I go to my profile page
        Then I should see "normal@example.com"
        And I should see "we need your current password"

    Scenario: An unauthenticated user cannot access the change password page
        Given I am not authenticated
        When I go to my profile page
        Then I should see "Log In" within "legend"


