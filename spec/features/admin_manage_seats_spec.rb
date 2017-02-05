require 'rails_helper.rb'

describe 'As an admin' do
  let(:admin) { FactoryGirl.create :user, admin: true }
  let(:event) { FactoryGirl.create(:event) }
  let!(:user) { FactoryGirl.create :user, email: 'will@example.com', username: 'Will' }
  let!(:seat) { FactoryGirl.create :seat, event: event }

  before { login_as admin }

  specify 'I can navigate to a list of all seats' do
    visit '/'
    click_link 'Events'
    within(:css, "#event_#{event.id}") do
      click_link 'Manage seating'
    end
    expect(page).to have_content "Seats - '#{event.name}'"
  end

  specify 'I can edit a seat' do
    visit edit_admin_event_seat_path(event, seat)
    fill_in 'Row', with: 'B'
    fill_in 'Number', with: '1'
    click_button 'Update Seat'
    expect(page).to have_content 'B1'
  end

  specify 'I can assign a user to a seat', js: true do
    visit edit_admin_event_seat_path(event, seat)
    select2('Will (will@example.com)', from: 'User')
    click_button 'Update Seat'
    expect(page).to have_content 'Will'
    expect(seat.reload.user.id).to eq user.id
  end

  specify 'I can delete a seat' do
    visit admin_event_seats_path(event)
    within(:css, "#seat_#{seat.id}") do
      click_link 'Delete'
    end
    expect(page).to_not have_content 'B1'
  end

  specify 'I can create a seat' do
    visit new_admin_event_seat_path(event)
    fill_in 'Row', with: 'Z'
    fill_in 'Number', with: '1'
    click_button 'Create Seat'
    expect(page).to have_content 'Z1'
  end
end

describe 'As a user' do
  let(:user) { FactoryGirl.create :user }
  let(:event) { FactoryGirl.create(:event) }
  let!(:seat) { FactoryGirl.create :seat, event: event }

  before { login_as user }

  specify 'I can not see a list of seats' do
    visit admin_event_seats_path(event)
    expect(page.status_code).to eq(404)
  end
end
