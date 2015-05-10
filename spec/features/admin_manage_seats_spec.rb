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
    visit edit_seat_path(seat)
    fill_in 'Row', with: 'B'
    click_button 'Update Seat'
    expect(page).to have_content 'B1'
  end

  specify 'I can delete a seat' do
    visit seats_path
    within(:css, "#seat_#{seat.id}") do
      click_link 'Delete'
    end
    expect(page).to_not have_content 'B1'
  end

  specify 'I can create a seat' do
    visit new_seat_path
    fill_in 'Row', with: 'Z'
    fill_in 'Number', with: '1'
    click_button 'Create Seat'
    expect(page).to have_content 'Z1'
  end

end
