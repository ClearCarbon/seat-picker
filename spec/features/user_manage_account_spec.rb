require 'rails_helper.rb'

describe 'As a user' do
  let!(:user) { FactoryGirl.create :user, password: 'password' }

  before { login_as user }

  specify 'I can navigate to my account page' do
    visit '/'
    click_link 'Update details'
    expect(page).to have_content 'Manage Account'
  end

  specify 'I can not change my username without my password', js: true do
    visit edit_user_registration_path
    fill_in :user_username, with: 'test change'
    click_button 'Update'
    expect(page).to have_content "Current password can't be blank"
  end

  specify 'I can change my username' do
    visit edit_user_registration_path
    fill_in :user_username, with: 'test change'
    fill_in :password, with: 'password'
    click_button 'Update'
    expect(user.reload.username).to eq 'test change'
  end

  specify 'I can delete my account' do
    visit cancel_account_users_path
    fill_in :cancel_password, with: 'password'
    click_button 'Cancel my account'
    expect(User.all.count).to eq 0
    expect(page).to have_content 'Your account has been deleted.'
  end

  specify 'I can not delete my account if my password is wrong' do
    visit cancel_account_users_path
    fill_in :cancel_password, with: 'badger'
    click_button 'Cancel my account'
    expect(User.all.count).to eq 1
    expect(page).to have_content 'Password invalid.'
  end

  specify 'I can not delete my account if I do not enter my password' do
    visit cancel_account_users_path
    click_button 'Cancel my account'
    expect(User.all.count).to eq 1
    expect(page).to have_content 'Password invalid.'
  end
end
