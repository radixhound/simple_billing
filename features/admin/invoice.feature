Feature: Add invoices
  As an administrator
  I want to add an invoice to a user
  So that I can get them to pay me an individual amount

  Background: 
    Given I am logged in as an admin user
    And there is a pending user "BobMarley"
    
  Scenario: Add an invoice
    Given I am on the admin user page for "BobMarley"
    When I add a $5.00 invoice for "Potatoes"
    Then I should be on the admin user page for "BobMarley"
    And I should see a pending invoice "Potatoes" for $5.00

  Scenario: Sending an invoice to a pending user
    Given "BobMarley" has a pending invoice "Broccoli" for $5.00
    When I send the invoice
    Then I should see a payable invoice "Broccoli" for $5.00
    And an invoice notification with activation link is sent to "BobMarley"

  Scenario: Edit an invoice
    Given "BobMarley" has a payable invoice "Potatoes" for $5.00
    And I am on the admin user page for "BobMarley"
    When I edit the invoice "Potatoes" to have:
      | title  | Bacon |
      | amount | 5.50  |
    Then I should be on the admin user page for "BobMarley"
    And I should see "Bacon" for $5.50
    And I should not see "Potatoes" for $5.00

  Scenario: Destroy an invoice
    Given "BobMarley" has a payable invoice "Potatoes" for $5.00
    And I am on the admin user page for "BobMarley"
    When I destroy the invoice for "Potatoes"
    Then I should be on the admin user page for "BobMarley"
    And I should not see "Potatoes" for $5.00

  Scenario: Send second invoice
    Given there is a user "Bill"
    And I have a valid card
    And I am on the admin user page for "Bill"
    When I add a $5.00 invoice for "Potatoes"
    And I send the invoice
    Then an invoice notification is sent to "Bill"