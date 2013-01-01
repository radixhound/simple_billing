Feature: Destroy users
    So that I can clean up my mess
    As an administrator
    I want to delete users from the system

    Background:
        Given I am logged in as an admin user
        And there is a user "BobMarley"

    Scenario: Destroy a user
        When I destroy "BobMarley"
        Then I should not see "BobMarley" on the Admin Dashboard
