Feature: Add invoices
  As an administrator
  I want to add an invoice to a user
  So that I can get them to pay me an individual amount

  Background: 
    Given I am logged in as an admin user
    And there is a user "BobMarley"
    
  Scenario: Add an invoice
    Given I am on the admin user page for "BobMarley"
    When I add a $5.00 invoice for "Potatoes"
    Then I should be on the admin user page for "BobMarley"
    And I should see "Potatoes" for $5.00

  Scenario: Edit an invoice
    Given there is a $5.00 invoice "Potatoes" for the user "BobMarley"
    And I am on the admin user page for "BobMarley"
    When I edit the invoice "Potatoes" to have:
      | title  | Bacon |
      | amount | 5.50  |
    Then I should be on the admin user page for "BobMarley"
    And I should see "Bacon" for $5.50
    And I should not see "Potatoes" for $5.00

  Scenario: Destroy an invoice
    Given there is a $5.00 invoice "Potatoes" for the user "BobMarley"
    And I am on the admin user page for "BobMarley"
    When I destroy the invoice for "Potatoes"
    Then I should be on the admin user page for "BobMarley"
    And I should not see "Potatoes" for $5.00