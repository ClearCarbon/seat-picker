require 'rails_helper.rb'

describe 'As an admin' do
  let(:admin) { FactoryGirl.create :user, admin: true }
  let!(:seat) { FactoryGirl.create :seat }

  before { login_as admin }

  specify 'I can navigate to a list of all seats' do
    visit '/'
    click_link 'Seats'
    expect(page).to have_content 'A1'
  end

  specify 'I can edit a seat' do
    visit edit_admin_seat_path(seat)
    fill_in 'Row', with: 'B'
    fill_in 'Number', with: '1'
    click_button 'Update Seat'
    expect(page).to have_content "B1"
  end

  specify 'I can delete a seat' do
    visit admin_seats_path
    within(:css, "#seat_#{seat.id}") do
      click_link 'Delete'
    end
    expect(page).to_not have_content 'B1'
  end

  specify 'I can create a seat' do
    visit new_admin_seat_path
    fill_in 'Row', with: 'Z'
    fill_in 'Number', with: '1'
    click_button 'Create Seat'
    expect(page).to have_content 'Z1'
  end

end

describe "As a user" do
  let(:user) { FactoryGirl.create :user }
  let!(:seat) { FactoryGirl.create :seat }

  before { login_as user }

  specify 'I can not see a list of seats' do
    visit admin_seats_path
    expect(page.status_code).to eq(404)
  end

end
