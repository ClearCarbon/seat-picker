Feature: Picker
As an authorized user
I want to pick my seat

Scenario: User is not logged in
  Given I am on the picker page
  Then the Login form should be shown
  And I should see "You need to sign in or sign up before continuing."

Scenario: Logged in user can see seats
  Given I am a new authenticated use
  Given I am on the picker page
  Then I should not have a seat
