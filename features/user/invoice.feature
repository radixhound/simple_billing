Feature: View invoices
  As a user
  I want to see a list of my bills
  So I can pay them

  Background:
    Given there is a user "Bob"
    And there is a $5.00 invoice "Potatoes" for the user "Bob"
    And there is a $6.00 invoice "Bacon" for the user "Bob"
    And I log in as a user "Bob"

  Scenario: View all invoices
    Given I am on my user page
    Then I should see my invoices

  Scenario: View individual invoice
    Given I am on my user page
    When I open the invoice for "Potatoes"
    Then I should be on the invoice page for "Potatoes"