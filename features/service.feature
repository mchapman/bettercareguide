Feature:
  In order to keep the data valuable
  As an owner of the site
  I want to the service data to be up to date and accessible

# If you add anything to the background add it to all_backgrounds.txt as well
Background:
  Given the following organisations exist
    | name                                             | url                     | organisation |
    | Care Quality Commission                          | www.cqc.org.uk          | cqc          |
    | Care4U                                           | http://www.example.com  | care4u       |
    | Carllton Mansions Care Home                      | www.fourseasons.com     | carlton      |
  And the following regulators with association exist
    | domain           | web_page_format                                                                                        | a_Organisation@name@organisation                 |
    | England2          | http://www.cqc.org.uk/registeredservicesdirectory/RSSearchDetail.asp?ID=%s                            | Care Quality Commission                          |
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
     |date_started_trading | date_started_trading_implied | description                    | a_Organisation@name@organisation | a_InternalServiceType@description@internal_service_type |
     |2009-09-09           | false                        | We are care4u                  | Care4U                           | Care at Home                                            |
     |2009-09-09           | false                        | We are carlton                 | Carllton Mansions Care Home      | Care in a Residential Home                              |
  Given the following users exist
    | email                  | password | roles_mask | accepted_t_and_cs |
    | normal@example.com     | secret   | 0          | 1                 |
    | admin@example.com      | secret   | 1          | 1                 |
  Given the following permissions with association exist
    | a_User@email@user  | a_Service@description@service | accepted |
    | normal@example.com | We are carlton                | true     |
  Given the following phone_types exist
    |id| description |
    | 1| Landline    |
    | 2| Fax         |

  Scenario: Owner updates escalator pitch, which then appears in search grid
    And I go to newsession
    Given I am a normal user
    And I go to homepage
    And I check "res"
    And I fill in "provider" with "rllto"
    And I fill in "geog" with ""
    And I press "Search"
    Then I should see "rllto"
    Then I should not see "John and Eileen think their service is great and welcome you"
    And I go to the view page for the service record with a slug of 'carllton-mansions-care-home-anytown'
    And I should see "Anytown"
    Then I should not see "John and Eileen think their service is great and welcome you"
    And I go to the edit page for the service record with a slug of 'carllton-mansions-care-home-anytown'
    And I fill in "service[elevator_pitch]" with "John and Eileen think their service is great and welcome you"
    And I press "Save"
    And I go to the view page for the service record with a slug of 'carllton-mansions-care-home-anytown'
    And I should see "Anytown"
    Then I should see "John and Eileen think their service is great and welcome you"
    And I go to homepage
    And I check "res"
    And I fill in "provider" with "rllto"
    And I fill in "geog" with ""
    And I press "Search"
    Then I should see "John and Eileen think their service is great and welcome you"

  Scenario: Owner updates full pitch which then appears on service view form
    And I go to newsession
    Given I am a normal user
    And I go to the view page for the service record with a description of 'We are carlton'
    Then I should not see "This service is really great."
    And I go to the edit page for the service record with a description of 'We are carlton'
    And I fill in "service_description" with "This service is really great.  We do loads of really good things and people like us loads.  Honest."
    And I press "Save"

  Scenario: Admin user goes to view record, selects update changes name and saves record
    And I go to newsession
    Given I am a admin user
    And I go to homepage
    And I check "res"
    And I fill in "provider" with "rllto"
    And I fill in "geog" with ""
    And I press "Search"
    And I follow "Carllton Mansions Care Home"
    And I follow "Update"
    And I fill in "service[organisation_attributes][name]" with "Carlton Mansions Care Home"
    And I press "Save"
    Then I should see "Carlton Mansions Care Home"

