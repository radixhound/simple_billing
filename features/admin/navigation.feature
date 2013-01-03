Feature: Admin area navigation
    So that I can navigate the admin area
    As an administrator
    I want to log in and navigate around

    Scenario: Admin area requires login
        Given I am not logged in
        When I visit the admin area
        Then I should be required to login

    Scenario: Admin area is inaccessible to users
        Given I am logged in as a user
        When I visit the admin area
        Then I should be on my user page

    Scenario: Login brings me to admin dashboard
        When I log in as an admin user
        Then I should be on the Admin Dashboard page

    Scenario: Return to dashboard
        Given I am logged in as an admin user
        And I am viewing a user
        Then I should be able to return to the dasboard

    Scenario: Log out
        Given I am logged in as an admin user
        Then I should be able to log out
