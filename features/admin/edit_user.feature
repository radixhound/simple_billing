Feature: Edit user
    So that I can keep user info up to date
    As an administrator
    I want to edit users 

    Background:
        Given I am logged in as an admin user
        And there is a pending user "BobMarley"

    Scenario: Edit a user
        When I edit the user "BobMarley" to have:
            | username | RobertMarley |
            | email    | rob@example.com |

        Then I should see "RobertMarley" on the Admin Dashboard
        And I should see "rob@example.com" on the Admin Dashboard
