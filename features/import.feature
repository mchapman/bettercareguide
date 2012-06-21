# This does not just test the import - it also sets up the database for further tests
Feature: Import functions
  In order to ensure data is useful
  As an author of the site
  I want to populate from good data sources

#    Scenario: Non admin user cannot access import page
#        Given I am not authenticated
#        When I go to import page
#        Then I should see "Access denied!"

#    Scenario: Admin user can import a sample from CQC website and it appears in search results
#        Given I am an admin user
#        When I go to import page
#        And I press "Import a test sample"
#        Then I should see "Job has been added to queue"
#        # Then clear the jobs queue so we can check that it is done
#        And the system processes jobs
#        And I go to homepage
#      And I check "Type_care_at_home"
#        And I fill in "provider" with "care"
#        And I press "Search"
#        Then I should see "Care4U"
#        And I should see "Wealden"

#    Scenario: If a new code gets set up without a mapping, send an email to the system admin

#    Scenario: Import from CQC website
#provider: Golden           http://caredirectory.cqc.org.uk/caredirectory/searchthecaredirectory.cfm?cit_id=1-101721115&widCall1=customWidgets.content_view_1&element=
#location: Golden           http://caredirectory.cqc.org.uk/caredirectory/searchthecaredirectory.cfm?widCall1=customWidgets.content_view_1&cit_id=1-101721115&element=REGISTER&page=1-120282238
#provider: Caremark Wealden http://caredirectory.cqc.org.uk/caredirectory/searchthecaredirectory.cfm?cit_id=1-126999601&widCall1=customWidgets.content_view_1&element=
#location: Caremark Wealden http://caredirectory.cqc.org.uk/caredirectory/searchthecaredirectory.cfm?widCall1=customWidgets.content_view_1&cit_id=1-126999601&element=REGISTER&page=1-138260418
