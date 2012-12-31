Feature: Add users
    So that I can bill users
    As an administrator
    I want to add them to the system

    Scenario: Add a user
        Given there are no users in the system
        When I add "Hyde Park Distribution" 
        Then I should see "Hyde Park Distribution" in the users list





