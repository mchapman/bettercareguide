Feature: Comment functions
  In order to attract users
  As an owner of the site
  I want to collect and display comments about services

# If you add anything to the background add it to all_backgrounds.txt as well
Background:
  Given the following users exist
    | email                  | password | roles_mask | accepted_t_and_cs |
    | normal@example.com     | secret   | 0          | 1                 |
    | another@example.com    | secret   | 0          | 1                 |
  Given the following organisations exist
    | name                                             | url                     | organisation |
    | Care Quality Commission                          | www.cqc.org.uk          | cqc          |
    | Care4U                                           | http://www.example.com  | care4u       |
    | Carlton Mansions Care Home                       | www.fourseasons.com     | carlton      |
  And the following regulators with association exist
    | domain   | web_page_format                                                             | a_Organisation@name@organisation |
    | England2 | http://www.cqc.org.uk/registeredservicesdirectory/RSSearchDetail.asp?ID=%s  | Care Quality Commission          |
  Given the following internal_service_types exist
    | description                 | requires_type_col | sort_order | seo_keywords |
    | Care in a Residential Home  | t                 | 2          | residential  |
    | Care at Home                | f                 | 1          | homecare     |
    | Other                       | t                 | 3          | nursing      |
  Given the following regulator_service_types with association exist
    | regulator_description              | a_Regulator@domain@regulator  | a_InternalServiceType@description@internal_service_type |
    | Care home with nursing%Care Home   | England2                      | Care in a Residential Home                              |
    | Domiciliary Care Agencies%         | England2                      | Care at Home                                            |
  And the following internal_sector_types exist
    | description     |
    | Private         |
  And the following regulator_sector_types with association exist
    | regulator_description  | a_Regulator@domain@regulator | a_InternalSectorType@description@internal_sector_type |
    | Private                | England2                     | Private                                               |
  And the following services with association exist
    | date_started_trading | date_started_trading_implied | description                    | a_Organisation@name@organisation | a_InternalServiceType@description@internal_service_type | invite_comment_up_to_stars |
    |2009-09-09            | false                        | We provide a starry service    | Care4U                           | Care at Home                                            |                            |
    |2009-09-09            | false                        | We are jolly good              | Carlton Mansions Care Home       | Care in a Residential Home                              | 3                          |
  Given the following phone_types exist
    |id| description |
    | 1| Landline    |
    | 2| Fax         |
  And the following rater_types exist
    | short_description      | long_description                                           |
    | Service User           | someone who uses the service                               |
    | Family of Service User | a family member of someone who uses the service            |
    | Employee               | employed by the service provider                           |
    | Care Professional      | a care professional working alongside the service provider |
    | Other                  | some other connection to provider (specify in comments)    |

  Scenario: a. Registered user adds comment to service that has a comment and no owner from the show page
    Given the following ratings with association exists
      | a_User@email@rater  | a_Service@description@service  | stars | a_RaterType@short_description@rater_type | comments |
      | another@example.com | We provide a starry service    | 5     | Service User                             | Lorem ipsum dolor sit amet, consectetur cras amet. |
    Given ReallyCare comment approval is not required
    Given I am a normal user
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "e4u"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Care4U"
    And I follow "Rate this service"
    And I select "someone who uses the service" from "rating_rater_type_id"
    And I choose "rate_4"
    And I fill in "comments" with "This is a good service - well done!  Lorem ipsum dolor sit amet, consectetur cras amet."
    And I press "Publish"
    Then I should see "Thank you, your comments"
    Then "normal@example.com" should receive an email
    And I open the email
    When I follow "follow this link" in the email
    Then I should see "This is a good service - well done!"
    Then I should see a service rating of 90
    And I should see 2 comments
    And I go to homepage
    And I press "Search"
    And I follow "Care4U"
    Then I should see "This is a good service - well done!"
    Then I should see a service rating of 90
    And I should see 2 comments

  Scenario: Registered user adds comment from view page, service owners get notified
    Given ReallyCare comment approval is not required
    Given the following permissions with association exist
      | a_User@email@user   | a_Service@description@service | accepted | email_all_ratings |
      | another@example.com | We are jolly good                        | true     | true              |
    And I am a normal user
    And I am on the view page for the service record with a description of 'We are jolly good'
    And I follow "Rate this service"
    And I select "someone who uses the service" from "rating_rater_type_id"
    And I choose "rate_4"
    And I fill in "comments" with "This is a good service - well done! Lorem ipsum dolor sit amet, consectetur cras amet."
    And I press "Publish"
    Then I should see "Thank you, your comments"
    Then "another@example.com" should receive an email
    And I open the email
    When I follow "follow this link" in the email
    Then I should see "This is a good service - well done!"
    Then I should see a service rating of 80

  Scenario: Service owner specifies comments <= 3* don't get published, such a comment is made and doesn't appear
    Given ReallyCare comment approval is not required
    Given the following permissions with association exist
      | a_User@email@user   | a_Service@description@service | accepted | email_all_ratings | notify_poor_ratings |
      | another@example.com | We are jolly good             | true     | true              | true                |
    And I am a normal user
    And I am on the view page for the service record with a description of 'We are jolly good'
    And I follow "Rate this service"
    And I select "someone who uses the service" from "rating_rater_type_id"
    And I choose "rate_3"
    And I fill in "comments" with "Their time keeping is not great  Lorem ipsum dolor sit amet, consectetur cras amet."
    And I press "Publish"
    Then I should see "Thank you, your comments"
    And I am on the view page for the service record with a description of 'We are jolly good'
    Then I should not see "Their time keeping is not great"
    Then I should not see a service rating of 60
    Then "normal@example.com" should have no emails
    Then "another@example.com" should receive an email
    And I am a another user
    And I open the email
    When I follow "following this link" in the email
    Then I should see "Their time keeping is not great"

  Scenario: Service owner does not respond to comment so it is published
    Given ReallyCare comment approval is not required
    Given the following ratings with association exists
    | a_User@email@rater  | a_Service@description@service | stars | a_RaterType@short_description@rater_type | comments |
    | another@example.com | We are jolly good             | 2     | Service User                             | rubbish! Lorem ipsum dolor sit amet, consectetur cras amet.|
    Given the following permissions with association exist
    | a_User@email@user   | a_Service@description@service | accepted | email_all_ratings | notify_poor_ratings |
    | normal@example.com  | We are jolly good             | true     | true              | true                |
    Then "another@example.com" should receive an email
    And I open the email
    And I am a normal user
    And I am on the respond page for the rating record with a stars of '2'
    Then I should see "rubbish!"
    And I press "Submit"
    And I should see "Rating was successfully updated."
    And "another@example.com" should receive an email
    Then "normal@example.com" should receive an email
    And I open the email
    When I follow "follow this link" in the email
    Then I should see a service rating of 40
    And I should see "rubbish!"

  Scenario: An Admin user cannot respond to a comment
    Given the following ratings with association exists
    | a_User@email@rater  | a_Service@description@service | stars | a_RaterType@short_description@rater_type | comments |
    | another@example.com | We are jolly good             | 2     | Service User                             | rubbish! Lorem ipsum dolor sit amet, consectetur cras amet.|
    Given the following permissions with association exist
    | a_User@email@user   | a_Service@description@service | accepted | email_all_ratings | notify_poor_ratings |
    | normal@example.com  | We are jolly good             | true     | true              | true                |
    Given the following users exist
    | email                  | password | roles_mask | accepted_t_and_cs |
    | admin@example.com      | secret   | 1          | 1                 |
    Then "another@example.com" should receive an email
    And I am a admin user
    And I am on the respond page for the rating record with a stars of '2'
    And I should see "Access denied"

  Scenario: Only a service owner of a service can respond to a comment
    Given the following ratings with association exists
    | a_User@email@rater  | a_Service@description@service | stars | a_RaterType@short_description@rater_type | comments |
    | another@example.com | We are jolly good             | 2     | Service User                             | rubbish! Lorem ipsum dolor sit amet, consectetur cras amet.|
    Then "another@example.com" should receive an email
    And I am a normal user
    And I am on the respond page for the rating record with a stars of '2'
    And I should see "Access denied"
    Given the following permissions with association exist
    | a_User@email@user   | a_Service@description@service | accepted | email_all_ratings | notify_poor_ratings |
    | normal@example.com  | We are jolly good             | true     | true              | true                |
    And I am a normal user
    And I am on the respond page for the rating record with a stars of '2'
    Then I should see "rubbish!"

  Scenario: Registered user adds comment from view page, service owners get notified
    Given ReallyCare comment approval is required
    And I am a normal user
    And I am on the view page for the service record with a description of 'We are jolly good'
    And I follow "Rate this service"
    And I select "someone who uses the service" from "rating_rater_type_id"
    And I choose "rate_4"
    And I fill in "comments" with "This is a good service - well done!  Lorem ipsum dolor sit amet, consectetur cras amet."
    And I press "Publish"
    Then I should see "Thank you, your comments"
    And I am on the view page for the service record with a description of 'We are jolly good'
    And I should not see "This is a good service - well done!"

  Scenario: Service owner can respond to comment
    Given ReallyCare comment approval is not required
    Given the following ratings with association exists
    | a_User@email@rater  | a_Service@description@service | stars | a_RaterType@short_description@rater_type | comments |
    | another@example.com | We are jolly good             | 2     | Service User                             | rubbish! Lorem ipsum dolor sit amet, consectetur cras amet.|
    Given the following permissions with association exist
    | a_User@email@user   | a_Service@description@service | accepted | email_all_ratings | notify_poor_ratings |
    | normal@example.com  | We are jolly good             | true     | true              | true                |
    Then "another@example.com" should receive an email
    And I open the email
    And I am a normal user
    And I am on the respond page for the rating record with a stars of '2'
    Then I should see "rubbish!"
    And I fill in "No - we are great" for "response_text"
    And I press "Submit"
    Then a rating should exist with response_text: "No - we are great"
    And I should see "Rating was successfully updated."

  Scenario: Service owner response is shown
    Given ReallyCare comment approval is not required
    Given the following ratings with association exists
    | a_User@email@rater  | a_Service@description@service | stars | a_RaterType@short_description@rater_type | comments                                                   | a_User@email@response_user | response_text                            | response_datetime |
    | another@example.com | We are jolly good             | 2     | Service User                             | rubbish! Lorem ipsum dolor sit amet, consectetur cras amet.| normal@example.com         | No it isn't - you are a nightmare client | 01/01/2011 13:45  |
    Then "another@example.com" should receive an email
    And I open the email with subject "Your care service rating has been published!"
    When I follow "follow this link" in the email
    And I should see "No it isn't - you are a nightmare client"
    And I should see "Service Provider representative"

  Scenario: *1 New user adds a comment from search results page to a service with no previous comments and no owner
    Given I am not authenticated
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "e4u"
    And I fill in "geog" with ""
    And I press "Search"
    Then I should see "Care4U"
    And I follow "Be the first!"
    And I fill in "email" with "test@test.com"
    And I select "someone who uses the service" from "rating_rater_type_id"
    And I choose "rate_5"
    And I fill in "comments" with "This is an exceptional service - well done! Lorem ipsum dolor sit amet, consectetur cras amet."
    And I select \(Time.now.year-1).to_s\ from "rating_effective_date_1i"
    And I select "December" from "rating_effective_date_2i"
    And I press "Publish"
    Then I should see "Terms and conditions must be accepted"
    And I check "accepted_t_and_cs"
    And I press "Publish"
    Then I should see "Thank you, your comments"
    And I go to homepage
    And I press "Search"
    Then I should see "Care4U"
    And I should see "Be the first!"
    And the system processes jobs
    Then "test@test.com" should receive an email
    And I open the email
    And I should see "Confirm my account" in the email body
    When I follow "Confirm my account" in the email
    Then I should see "Your account was successfully confirmed. You are now signed in."
    And the system processes jobs
    Then "test@test.com" should have 2 emails
    And I open the email with subject "Your care service rating has been published!"
    When I follow "follow this link" in the email
    Then I should see "This is an exceptional service"
    Then I should see a service rating of 100
    And I should see 1 comment

  Scenario: *2 Duplicate email cannot be used - user is asked to log in if their email is already on file.
    Given I am not authenticated
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "e4u"
    And I fill in "geog" with ""
    And I press "Search"
    Then I should see "Care4U"
    And I follow "Be the first!"
    And I fill in "email" with "normal@example.com"
    And I select "someone who uses the service" from "rating_rater_type_id"
    And I choose "rate_4"
    And I fill in "comments" with "This is a very good service - quite well done!  Lorem ipsum dolor sit amet, consectetur cras amet."
    And I press "Publish"
    Then I should see "Please log in to rate a service"
    And I should see "Forgot your password?"

  Scenario: *3 Registered user adds comment previews publishes
    Given ReallyCare comment approval is not required
    Given I am a normal user
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "e4u"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Care4U"
    And I follow "Rate this service"
    And I select "someone who uses the service" from "rating_rater_type_id"
    And I choose "rate_4"
    And I fill in "comments" with "This is a good service - well done!  Lorem ipsum dolor sit amet, consectetur cras amet."
    And I press "Preview"
    Then I should see "This is a good service"
    And I press "Publish"
    Then I should see "Thank you, your comments"
    And I go to homepage
    And I press "Search"
    And I follow "Care4U"
    Then I should see a service rating of 80
    And I should see 1 comment


  Scenario: *4 A Registered user adds comment previews edits previews publishes
    Given ReallyCare comment approval is not required
    Given I am a normal user
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "e4u"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Care4U"
    And I follow "Rate this service"
    And I select "someone who uses the service" from "rating_rater_type_id"
    And I choose "rate_4"
    And I fill in "comments" with "This is a good service - well done!  Lorem ipsum dolor sit amet, consectetur cras amet."
    And I press "Preview"
    Then I should see "Rated by Service User, "
    And I should see "good service"
    And I should see a comment rating of 80
    And I press "Amend"
    And I choose "rate_5"
    And I fill in "comments" with "This is an excellent service - well done!  Lorem ipsum dolor sit amet, consectetur cras amet."
    And I press "Preview"
    Then I should see "Rated by Service User, "
    And I should see "excellent service"
    And I should see a comment rating of 100
    And I press "Publish"
    And I go to homepage
    And I press "Search"
    And I follow "Care4U"
    Then I should see a service rating of 100
    And I should see 1 comments
    And I should see "excellent service"

  Scenario: Stuff to collapse.  Future scenarios in here in the comments
#
#  Scenario: User gets to see all ratings they haven't commented on
#
#  Scenario: Comments need to be OK'd by reallycare.org before being published, in case of spam
#            or inappropriate content.  Reallycare suggest a mod, which is accepted by user.
#            are recorded but not displayed.
#    Given this is a pending step
#
#  Scenario: Service owner specifies comments <= 3* don't get published, such a comment is made
#            and service owner suggests a mod which is accepted by user.
#            are recorded but not displayed.
#    Given this is a pending step
#
#  Scenario: Service owner specifies comments <= 3* don't get published, such a comment is made
#            and service owner suggests a mod which is not accepted by user.
#            are recorded and displayed.
#    Given this is a pending step
#
#  Scenario: Service owner specifies comments <= 3* don't get published, such a comment is made
#            and service owner does not reply within the time limit, so comment is published.
#    Given this is a pending step
#  Scenario: Service owner doesn't respond within 3 days

# Check for someone who amends email address in the amend screen
# Improve effective_date error checking and move (where possible) to model
# Pick up a Preview that wasn't saved, if it is there
# Prevent user rating a service twice (though keep record)
# Logged in user needs to confirm they sent the rating
# Javascript rating
# Make sure that people who have claimed services cannot rate services (especially the one they claim, and any close competitors)
# Add titles everywhere they are needed
# Add maps???
#
#
#  Scenario: Rate this service page – category ratings
#
#    Given that I am on the “Rate this service” page
#
#    And have entered whether I am a customer or a representative
#
#    And I have specified when I last used the service
#
#    And I have entered a rating against each category I have chosen
#
#    When I have entered a free text comment
#
#    Then I will be able to preview the review
#
#
#
#  Scenario: Rate this service page – Preview the review
#
#    Given that I am on the “Rate this service” page
#
#    And have entered whether I am a customer or a representative
#
#    And I have specified when I last used the service
#
#    And have entered a rating against each category I have chosen
#
#    And have entered free text comments
#
#    When I click “Preview this review”
#
#    Then I will be shown a preview of the review
#
#
#
#  Scenario: Rate this service – Publish review, no further edits
#
#    Given that I am on the preview review page
#
#    And I do not want to make further edits
#
#    When I click the “Publish this review” button
#
#    Then I will be thanked for my review and be prompted that it is being processed before being displayed within approx. 48 hours
#
#
#  Scenario: Rate this service – Publish Review, further edits
#
#    Given
#
#    And
#
#    When
#
#    Then
#
#
#
#  Scenario: Review processing – owned service
#
#    Given
#
#    And
#
#    When
#
#    Then
#
#
#
#  Scenario: Review processing – not owned service
#
#    Given
#
#    And
#
#    When
#
#    Then
#
#
#
#  Scenario: Rate the review – was this review useful?
#
#    Given
#
#    And
#
#    When
#
#    Then

# Low priority
#  Scenario:  Entering log in details from the “Rate this service” page
#
#    Given that I have entered my log in details
#
#    And was previously on the “Service details” page
#
#    When I click on log in
#
#    Then I should be sent to the “Rate this service” page of the selected service
  Given I am a normal user