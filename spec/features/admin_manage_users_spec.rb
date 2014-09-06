require 'rails_helper.rb'

describe 'As an admin' do 
  let!(:user) { FactoryGirl.create :user, email: 'bob@example.com', 
    username: 'Bob'}
  let(:admin) { FactoryGirl.create :user, admin: true }

  before { login_as admin }

  specify 'I can vew a list of all users' do
    visit '/'
    click_link 'Users'
    expect(page).to have_content 'bob@example.com'
    expect(page).to have_content 'Bob'
  end

  specify 'I can edit a user' do
    visit '/'
    click_link 'Users'
    within(:css, "#user#{user.id}") do
      click_link 'Edit'
    end
    fill_in 'Username', with: 'New Name'
    click_button 'Update User'
    expect(page).to have_content 'New Name'
  end

end
