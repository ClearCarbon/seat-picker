require 'rails_helper.rb'

describe 'As a user', js: true do
  let!(:user) { FactoryGirl.create :user, password: 'password' }
  let!(:seat1) { FactoryGirl.create :seat }
  let!(:seat2) { FactoryGirl.create :seat }

  before { login_as user }

  specify "I can pick my seat" do
    visit seats_path
    find(:css, "#seat_#{seat1.id}").click
    click_link 'Pick this seat'
    wait_for_ajax
    expect(page).to have_content "You are currently sat in seat #{seat1.decorate.name}"
  end

  context 'that has already picked a seat' do
    let!(:seat1) { FactoryGirl.create :seat, user: user }

    specify "I can give up my seat" do
      visit seats_path
      click_link 'Give up my seat'
      wait_for_ajax
      expect(page).to_not have_content "You are currently sat in seat #{seat1.decorate.name}"
    end

    specify "I can not pick a seat I have already picked" do
      visit seats_path
      find(:css, "#seat_#{seat1.id}").click
      wait_for_ajax
      expect(page).to_not have_link 'Pick this seat'
      expect(page).to have_content 'This is your current seat.'
    end
  end

  context "with another user in the system that has picked a seat", js: true do
    let!(:other_user) { FactoryGirl.create :user, password: 'password', seat: seat1 }

    specify "I can not pick a seat another user has picked" do
      visit seats_path
      find(:css, "#seat_#{seat1.id}").click
      wait_for_ajax
      expect(page).to_not have_link 'Pick this seat'
      expect(page).to have_link 'Request this seat'
    end

    specify "I can request an already picked seat" do
      visit seats_path
      find(:css, "#seat_#{seat1.id}").click
      click_link 'Request this seat'
      wait_for_ajax
      expect(SeatRequest.count).to eq(1)
    end

    context 'and I have requested the seat' do
      let!(:request) { FactoryGirl.create(:seat_request, seat: seat1, user: user) }
      
      specify "I can cancel my seat request" do
        visit seats_path
        click_link 'Cancel request'
        wait_for_ajax
        expect(page).to_not have_content 'Your have requested the following seat'
      end
    end
  end
end