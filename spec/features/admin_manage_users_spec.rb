require 'rails_helper.rb'

describe 'As an admin' do
  let!(:user) do
    FactoryGirl.create :user, email: 'bob@example.com',
                              username: 'Bob'
  end
  let(:admin) { FactoryGirl.create :user, admin: true }

  before { login_as admin }

  specify 'I can vew a list of all users' do
    visit '/'
    click_link 'Users'
    expect(page).to have_content 'bob@example.com'
    expect(page).to have_content 'Bob'
  end

  specify 'I can edit a user' do
    visit edit_admin_user_path(user)
    fill_in 'Username', with: 'New Name'
    click_button 'Update User'
    expect(page).to have_content 'New Name'
  end

  specify 'I can delete a user' do
    visit admin_users_path
    within(:css, "#user_#{user.id}") do
      click_link 'Delete'
    end
    expect(page).to_not have_content 'bob@example.com'
    expect(page).to_not have_content user.username
  end

  specify 'I can create a user' do
    visit new_admin_user_path
    fill_in 'Username', with: 'New User'
    fill_in 'Email', with: 'test@example.com'
    click_button 'Create User'
    expect(page).to have_content 'New User'
    expect(page).to have_content 'test@example.com'
  end

  specify 'I can promote a user' do
    visit edit_admin_user_path(user)
    click_link 'Promote'
    expect(page).to have_link 'Demote'
    expect(user.reload.admin?).to eq(true)
  end

  specify 'I can demote a user' do
    user.update_attributes(admin: true)
    visit edit_admin_user_path(user)
    click_link 'Demote'
    expect(page).to have_link 'Promote'
    expect(user.reload.admin?).to eq(false)
  end
end

describe 'As a user' do
  let(:user) { FactoryGirl.create :user }
  let!(:user) do
    FactoryGirl.create :user, email: 'bob@example.com',
                              username: 'Bob'
  end

  before { login_as user }

  specify 'I can not see a list of users' do
    visit admin_users_path
    expect(page.status_code).to eq(404)
  end
end
