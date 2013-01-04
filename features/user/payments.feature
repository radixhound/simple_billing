Feature: Bill payment
  As a user
  I want to add my payment information
  So that I can pay my bills

  Background:
    Given there is a user "Bob"
    And there is a $5.00 invoice "Potatoes" for the user "Bob"
    And I log in as a user "Bob"

  Scenario: Pay my bill
    Given I am on my user page
    When I open the invoice for "Potatoes"
    And I make a payment
    Then the invoice for "Potatoes" should be marked as paid

  Scenario: Back out of payment
    Given I am on my user page
    When I open the invoice for "Potatoes"
    And I do not confirm payment
    Then the invoice for "Potatoes" should not be marked as paid