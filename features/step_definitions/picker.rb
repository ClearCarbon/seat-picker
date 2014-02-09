Given(/^I am on the picker page$/) do
  visit "/picker"
end

Then(/^the Login form should be shown$/) do
  expect(page).to have_content 'Sign in'
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content text
end

Given(/^I am a new authenticated use$/) do
  email = 'user@example.com'
  password = 'password'
  User.new(:email => email, 
    :password => password, 
    :password_confirmation => password).save!

  visit '/users/sign_in'
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  click_button "Sign in"
end

Then(/^I should not have a seat$/) do
  expect(page).to have_content 'You currently have no seat'
end
