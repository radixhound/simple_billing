Feature: Add users
    So that I can bill users
    As an administrator
    I want to add them to the system

    Background: 
        Given I am logged in as an admin user
        
    Scenario: Add a user
        Given there are no users in the system
        When I add "Hyde Park Distribution" 
        Then I should see "Hyde Park Distribution" on the Admin Dashboard
        And "Hyde Park Distribution" has a signup token