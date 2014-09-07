require 'rails_helper.rb'

describe 'As an admin' do 
  let(:admin) { FactoryGirl.create :user, admin: true }
  let!(:seat) { FactoryGirl.create :seat }

  before { login_as admin }

  specify 'I can vew a list of all seats' do
    visit '/'
    click_link 'Seats'
    expect(page).to have_content 'A1'
  end

  specify 'I can edit a seat' do
    visit '/'
    click_link 'Seats'
    within(:css, "#seat#{seat.id}") do
      click_link 'Edit'
    end
    fill_in 'Row', with: 'B'
    click_button 'Update Seat'
    expect(page).to have_content 'B1'
  end

end
