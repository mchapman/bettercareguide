Feature: Administration functions
  In order to make the site meaningful
  As an administrator
  I want to create and manage code files


Background:
# If you add anything to the background add it to all_backgrounds.txt as well
  Given the following users exist
    | email                  | password | roles_mask | accepted_t_and_cs |
    | normal@example.com     | secret   | 0          | 1                 |
    | admin@example.com      | secret   | 1          | 1                 |
    | reallycare@example.com | secret   | 2          | 1                 |


  Scenario: No access to organisation page when not logged in
    Given I am not authenticated
    When I go to the organisations page
    Then I should see "Access denied!"

  Scenario: Gain access to organisation page when logged in as Admin
    Given I am an admin user
    When I go to the organisations page
    Then I should see "Listing organisations"


