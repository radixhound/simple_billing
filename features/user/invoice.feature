Feature: View invoices
  As a user
  I want to see a list of my bills
  So I can pay them

  Background:
    Given there is a user "Bob"
    And "Bob" has a payable invoice "Potatoes" for $5.00
    And "Bob" has a payable invoice "Bacon" for $6.00
    And I log in as a user "Bob"
    And "Bob" has a pending invoice "Broccoli" for $5.01

  Scenario: View all invoices
    Given I am on my user page
    Then I should see my invoices:
    | title    | amount |
    | Potatoes | $5.00  |
    | Bacon    | $6.00  |
    And I should not see "Broccoli" for $5.01

  Scenario: View individual invoice
    Given I am on my user page
    When I open the invoice for "Potatoes"
    Then I should be on the invoice page for "Potatoes"