Feature: Service provider edit rights given to 'owners'
  In order to keep the data valuable
  As an owner of the site
  I want to allow business users to update their own records

Background:
# If you add anything to the background add it to all_backgrounds.txt as well
  Given the following users exist
    | email                  | password | roles_mask | accepted_t_and_cs |
    | normal@example.com     | secret   | 0          | 1                 |
  Given the following organisations exist
    | name                                             | url                     |
    | Care Quality Commission                          | www.cqc.org.uk          |
    | The Care Commission                              | www.carecommission.com  |
    | Care and Social Services Inspectorate Wales      | www.csiw.wales.gov.uk   |
    | The Regulation and Quality Improvement Authority | www.rqia.org.uk         |
    | Care4U                                           | http://www.example.com  |
    | Carlton Mansions Care Home                       | www.fourseasons.com     |
  And the following regulators with association exist
    | domain           | web_page_format                                                               | a_Organisation@name@organisation                 |
    | England2         | http://www.cqc.org.uk/registeredservicesdirectory/RSSearchDetail.asp?ID=%s    | Care Quality Commission                          |
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
  Given the following phone_types exist
    |id| description |
    | 1| Landline    |
    | 2| Fax         |
  And the following regulator_sector_types with association exist
    | regulator_description  | a_Regulator@domain@regulator | a_InternalSectorType@description@internal_sector_type |
    | Private                | England2                     | Private                                               |
  And the following services with association exist
     |date_started_trading | date_started_trading_implied | description                    | a_Organisation@name@organisation | a_InternalServiceType@description@internal_service_type |
     |2009-09-09           | false                        | We are care4u                  | Care4U                           | Care at Home                                            |
     |2009-09-09           | false                        | We are carlton                 | Carlton Mansions Care Home       | Care in a Residential Home                              |

  Scenario: Unauthenicated user is asked to log in first
    Given I am not authenticated
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "e4u"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Care4U"
    Then I should see "Care4U" within "h1"
    And I follow "Click here if you represent this service"
    Then I should see "You need to be logged in to register yourself as the service provider."

  Scenario: Authenticated user gets automatic acceptance if the domain matches
    Given I am a normal user
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "e4u"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Care4U"
    Then I should see "Care4U" within "h1"
    And I follow "Click here if you represent this service"
    Then I should see "Here are some of the things you can do now"
    And I follow "Click here to proceed"
    And I should see "Users" within ".nav-tabs"

  Scenario: Authenticated user gets choice of validation methods if the domain does not match and chooses fax
    Given I am a normal user
    And I go to homepage
    And I check "res"
    And I fill in "provider" with "arl"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Carlton Mansions Care Home"
    Then I should see "Carlton Mansions Care Home" within "h1"
    And I follow "Click here if you represent this service"
    Then I should see "We fax you the code straight away"
    Then I choose "ac_method_fax"
    When I fill in "forename" with "John"
    And I fill in "surname" with "Normal"
    And I press "Proceed"
    And the system processes jobs
#    Then "normal@example.com" should receive an email
    Then "bettercareguide@reallycare.org" should receive an email
    And I open the email
    And I should see "To enter the access code visit" in the email body
    And I go to homepage
    And I check "res"
    And I fill in "provider" with "arl"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Carlton Mansions Care Home"
    Then I should see "Carlton Mansions Care Home" within "h1"
    Then I should not see "Click here if you represent this service"
    And I should see "Access Code"
    And I am not authenticated
    And I go to homepage
    And I check "res"
    And I fill in "provider" with "arl"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Carlton Mansions Care Home"
    Then I should see "Carlton Mansions Care Home" within "h1"
    And I should see "Click here if you represent this service"
    And I should not see "Access Code"

  Scenario: An unauthorised user cannot access a dashboard
    Given I am not authenticated
    And I go to homepage
    Then I should not see "Dashboard"

  Scenario: Authenticated user doesn't see My Service or My Access
    Given I am a normal user
    And I go to my dashboard
    Then I should not see "My Service"
    And I should not see "Access Code"

  Scenario: Authenticated user can put in access code
    Given the following permissions with association exist
      | a_User@email@user  | a_Service@description@service |
      | normal@example.com | We are carlton                |
    Given I am a normal user
    And I go to my dashboard
    Then I should not see "My Services"
    And I follow "Enter access code"
    And I fill in "access_code" with "12345"
    Then I press "Process Access Code"
    And I go to my dashboard
    And I should not see "Enter access code"
    Then I follow "Edit Service"
    Then the "service_organisation_attributes_name" field should contain "Carlton Mansions Care Home"

  Scenario: Authenticated user cannot edit a site they have no permissions for
    Given I am a normal user
    And I go to the edit page for the service record with a description of 'We are carlton'
    Then I should see "Access denied"

  Scenario: Authenticated user can edit a site they have permissions for
    Given the following permissions with association exist
      | a_User@email@user  | a_Service@description@service | accepted |
      | normal@example.com | We are carlton                                 | true     |
    Given I am a normal user
    And I go to my dashboard
    Then I should see "My Service"
    And I go to the edit page for the service record with a description of 'We are carlton'
    Then I should not see "Access denied"
    And the "service_organisation_attributes_name" field should contain "Carlton Mansions Care Home"

  Scenario: Service owner gets to see public view and can move between the two
    Given the following permissions with association exist
      | a_User@email@user  | a_Service@description@service | accepted |
      | normal@example.com | We are carlton                                 | true     |
    Given I am a normal user
    And I go to my dashboard
    Then I follow "Edit Service"
    And I press "Save and see public view"
    And I follow "Update"
    And I press "Save and see public view"
    And I follow "Update"
    And I press "Save and see public view"
    Then I should see "Update" within ".form-actions"

  Scenario: Service owner with no person record must enter name to get ownership
    Given I am a normal user
    And I go to the view page for the service record with a description of 'We are carlton'
    And I follow "Click here if you represent this service"
    Then I should see "We fax you the code straight away"
    Then I choose "ac_method_fax"
    And I press "Proceed"
    Then I should see "You must enter your forename and your surname"

  Scenario: Service owner with no person record gets added as a person
    Given I am a normal user
    And I go to the view page for the service record with a description of 'We are carlton'
    And I follow "Click here if you represent this service"
    Then I should see "We fax you the code straight away"
    Then I choose "ac_method_fax"
    When I fill in "forename" with "John"
    And I fill in "surname" with "Normal"
    And I press "Proceed"
    Then a person should exist with given_name: "John", family_name: "Normal"

  Scenario: Service owner with person record does not get prompted for name
    Given the following people with association exist
      | a_User@email@user  | family_name | given_name |
      | normal@example.com | Doe         | John       |
    Given I am a normal user
    And I go to the view page for the service record with a description of 'We are carlton'
    And I follow "Click here if you represent this service"
    Then I should see "We fax you the code straight away"
    And I should not see "Forename"

  Scenario: User must select something from radio button group or generate error
    Given I am a normal user
    And I go to the view page for the service record with a description of 'We are carlton'
    And I follow "Click here if you represent this service"
    Then I should see "We fax you the code straight away"
    When I fill in "forename" with "John"
    And I fill in "surname" with "Normal"
    And I press "Proceed"
    Then I should see "You must select a row from the options table."
    And I should see "We fax you the code straight away"

  Scenario: Ampersands in service name should not cock up fax
    Given the following organisations exist
      | name      |
      | A&B Care  |
    And the following services with association exist
      |date_started_trading | date_started_trading_implied | description                    | a_Organisation@name@organisation | a_InternalServiceType@description@internal_service_type |
      |2009-09-09           | false                        | we are ab                      | A&B Care                         | Care at Home                                            |
    Given I am a normal user
    And I go to the view page for the service record with a description of 'we are ab'
    And I follow "Click here if you represent this service"
    Then I choose "ac_method_fax"
    When I fill in "forename" with "John"
    And I fill in "surname" with "Normal"
    And I press "Proceed"
    And the system processes jobs
#    Then "normal@example.com" should receive an email
    Then "bettercareguide@reallycare.org" should receive an email
    And I open the email
    And I should see "A&B Care" in the email body

  Scenario: *6a Authenticated user gets automatic acceptance if they are the main email
    Given the following organisations exist
      | name                              | main_email            |
      | Anyold Care                       | normal@example.com    |
    And the following services with association exist
      |date_started_trading | date_started_trading_implied | description                    | a_Organisation@name@organisation | a_InternalServiceType@description@internal_service_type |
      |2009-09-09           | false                        | We are anyold care             | Anyold Care                      | Care at Home                                            |
    Given I am a normal user
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "Anyold"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Anyold Care"
    Then I should see "Anyold Care" within "h1"
    And I follow "Click here if you represent this service"
    Then I should see "Here are some of the things you can do now"
    And I follow "Click here to proceed"
    And I should see "Users" within ".nav-tabs"

#TODO: Have a rescan request and a figure something out flag on the service and put follow up on Admin / Reallycare dashboards. Contact number may also be required, or stored at the point of requesting thh action