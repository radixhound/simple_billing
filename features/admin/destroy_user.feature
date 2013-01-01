Feature: Destroy users
    So that I can clean up my mess
    As an administrator
    I want to delete users from the system

    Background:
        Given I am logged in as an admin user

    Scenario: Destroy a user
        Given there is a user "BobMarley"
        When I destroy "BobMarley"
        Then I should not see "BobMarley" on the Admin Dashboard

    Scenario: Destroy yourself
        Given I am on the Admin Dashboard
        Then I should not be able to destroy myself

