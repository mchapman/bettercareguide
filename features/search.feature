Feature: Search functions
  In order to attract users
  As an owner of the site
  I want to provide search capabilities

# If you add anything to the background add it to all_backgrounds.txt as well
Background:
  Given the following organisations exist
    | name                                             | url                     | organisation |
    | Care Quality Commission                          | www.cqc.org.uk          | cqc          |
    | Care4U                                           | http://www.example.com  | care4u       |
    | Carlton Mansions Care Home                       | www.fourseasons.com     | carlton      |
  And the following regulators with association exist
    | domain           | web_page_format                                                                                        | a_Organisation@name@organisation                 |
    | England          | http://www.cqc.org.uk/registeredservicesdirectory/RSSearchDetail.asp?ID=%010d                          | Care Quality Commission                          |
  Given the following internal_service_types exist
    | description                 | requires_type_col | sort_order | seo_keywords |
    | Care in a Residential Home  | t                 | 2          | residential  |
    | Care at Home                | f                 | 1          | homecare     |
    | Other                       | t                 | 3          | nursing      |
  Given the following regulator_service_types with association exist
    | regulator_description              | a_Regulator@domain@regulator  | a_InternalServiceType@description@internal_service_type |
    | Care home with nursing%Care Home   | England                       | Care in a Residential Home                              |
    | Domiciliary Care Agencies%         | England                       | Care at Home                                            |
  And the following internal_sector_types exist
    | description     |
    | Private         |
  And the following regulator_sector_types with association exist
    | regulator_description  | a_Regulator@domain@regulator | a_InternalSectorType@description@internal_sector_type |
    | Private                | England                      | Private                                               |
  And the following services with association exist
     |date_started_trading | date_started_trading_implied | description                    | a_Organisation@name@organisation | a_InternalServiceType@description@internal_service_type |
     |2009-09-09           | false                        | We are care4u                  | Care4U                           | Care at Home                                            |
     |2009-09-09           | false                        | We are carlton                 | Carlton Mansions Care Home       | Care in a Residential Home                              |

  Scenario: Search by service name and find something
    Given I am not authenticated
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "e4u"
    And I fill in "geog" with ""
    And I press "Search"
    Then I should see "Care4U"
    And I should not see "Distance"
    And I should see "Be the first!"

  Scenario: Search by service name and fail to find it
    Given I am not authenticated
    And I go to homepage
    And I check "dom"
    And I fill in "provider" with "Wealden"
    And I fill in "geog" with ""
    And I press "Search"
    Then I should see "No results found - check your search criteria"

  Scenario: Search by geography and find something
    Given I am not authenticated
    And I go to homepage
    And I check "dom"
    And I fill in "geog" with "Uckfield"
    And I fill in "radius" with "15"
    And I fill in "provider" with ""
    And I press "Search"
    Then I should not see "Cannot work out where"
    And I should see "Care4U"
    And I should see "2."

#  Scenario: Search by geography and fail to find it
#    Given the following towns exist
#      | name                                             | lat                     | lng   |
#      | TAUNTON                                          | 51.02                   |-3.105 |
#    Given I am not authenticated
#    And I go to homepage
#    And I check "dom"
#    And I fill in "provider" with ""
#    And I fill in "geog" with "Taunton"
#    And I fill in "radius" with "15"
#    And I press "Search"
#    And I should not see "Cannot work out where"
#    Then I should see "No results found - check your search criteria"
#
#  Scenario: Handle invalid address entry that returns results from Google
#    Given I am not authenticated
#    And I go to homepage
#    And I check "dom"
#    And I fill in "provider" with ""
#    And I fill in "geog" with "er4tttt,uk"
#    And I fill in "radius" with "15"
#    And I press "Search"
#    Then I should see "Cannot work out where"
#
#  Scenario: Handle another invalid address entry that returns results form Google
#    Given I am not authenticated
#    And I go to homepage
#    And I check "dom"
#    And I fill in "provider" with ""
#    And I fill in "geog" with "asdf,ghjk,qwer,tyyui"
#    And I fill in "radius" with "15"
#    And I press "Search"
#    Then I should see "Cannot work out where"
#
#  Scenario: Search by service name and wrong type and find nothing
#    Given I am not authenticated
#    And I go to homepage
#    And I check "res"
#    And I fill in "provider" with "e4u"
#    And I fill in "geog" with ""
#    And I press "Search"
#    Then I should see "No results found - check your search criteria"


