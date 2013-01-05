Feature: Signup users

    So that I can pay my bills securely
    As a user
    I want to set my password and CC information at the signup page

    Background: 
        Given There is a pending user "Bob"
        
    Scenario: User activates their account
        When I visit the activation page for "Bob"
        And I fill in my password
        Then I should be on the user page for "Bob"
        And I should see "Signup successful"

    @javascript
    Scenario: User activates their account with billing info
        When I visit the activation page for "Bob"
        And I enter my billing information
        And I fill in my password 
        Then I should be on the user page for "Bob"
        And I should see "Signup successful"
        And the user should see his card information