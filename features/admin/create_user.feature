Feature: Add users
    So that I can bill users
    As an administrator
    I want to add them to the system

    Background: 
        Given I am logged in as an admin user
        
    Scenario: Add a user
        Given there are no users in the system
        When I add "Bill" 
        Then I should see "Bill" on the Admin Dashboard
        And "Bill" has a signup token
        And an email with activation link is sent to "Bill"