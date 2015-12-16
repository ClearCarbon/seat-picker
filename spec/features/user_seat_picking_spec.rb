require 'rails_helper.rb'

describe 'As a user', js: true do
  let!(:user) { FactoryGirl.create :user, password: 'password' }
  let!(:seat1) { FactoryGirl.create :seat }
  let!(:seat2) { FactoryGirl.create :seat }

  before { login_as user }

  specify 'I can pick my seat' do
    visit seats_path
    find(:css, "#seat_#{seat1.id}").click
    click_link 'Pick this seat'
    wait_for_ajax
    expect(page).to have_content "You are currently sat in seat #{seat1.decorate.name}"
  end

  context 'when a seat is reserved' do
    let!(:seat1) { FactoryGirl.create :seat, reserved: true }

    specify 'I can not pick the reserved seat' do
      visit seats_path
      find(:css, "#seat_#{seat1.id}").click
      expect(page).to_not have_link 'Pick this seat'
    end
  end

  context 'that has already picked a seat' do
    let!(:seat1) { FactoryGirl.create :seat, user: user }

    specify 'I can give up my seat' do
      visit seats_path
      click_link 'Give up my seat'
      wait_for_ajax
      expect(page).to_not have_content "You are currently sat in seat #{seat1.decorate.name}"
    end

    specify 'I can not pick a seat I have already picked' do
      visit seats_path
      find(:css, "#seat_#{seat1.id}").click
      wait_for_ajax
      expect(page).to_not have_link 'Pick this seat'
      expect(page).to have_content 'This is your current seat.'
    end
  end

  context 'with another user in the system that has picked a seat' do
    let!(:other_user) { FactoryGirl.create :user, password: 'password', seat: seat1 }

    specify 'I can not pick a seat another user has picked' do
      visit seats_path
      find(:css, "#seat_#{seat1.id}").click
      wait_for_ajax
      expect(page).to_not have_link 'Pick this seat'
      expect(page).to have_link 'Request this seat'
    end

    specify 'I can request an already picked seat' do
      visit seats_path
      find(:css, "#seat_#{seat1.id}").click
      click_link 'Request this seat'
      wait_for_ajax
      fill_in 'Reason', with: 'request reason'
      click_button 'Request seat'
      wait_for_ajax
      expect(SeatRequest.count).to eq(1)
      expect(SeatRequest.first.reason).to eq('request reason')
      mail = ActionMailer::Base.deliveries.last
      expect(mail.body).to have_content 'You will need to pick a new seat for yourself'
      expect(mail.to).to have_content other_user.email
    end

    context 'and I have requested the seat' do
      let!(:request) { FactoryGirl.create(:seat_request, seat: seat1, user: user) }

      specify 'I can cancel my seat request within the sidebar' do
        visit seats_path
        within(:css, '#sidebar-actions') do
          click_link 'Cancel request'
          wait_for_ajax
          expect(page).to_not have_content 'Your have requested the following seat'
          mail = ActionMailer::Base.deliveries.last
          expect(mail.body).to have_content 'has cancelled their request for your seat.'
          expect(mail.to).to have_content other_user.email
        end
      end

      specify 'I can cancel my seat request by clicking on a seat' do
        visit seats_path
        find(:css, "#seat_#{seat1.id}").click
        within(:css, '.popover-content') do
          click_link 'Cancel request'
          wait_for_ajax
          expect(SeatRequest.all.count).to eq 0
          mail = ActionMailer::Base.deliveries.last
          expect(mail.body).to have_content 'has cancelled their request for your seat.'
          expect(mail.to).to have_content other_user.email
        end
      end
    end
  end

  context 'with another user in the system has requested my seat' do
    let!(:seat1) { FactoryGirl.create :seat, user: user }
    let!(:other_user) { FactoryGirl.create :user, password: 'password' }
    let!(:request) { FactoryGirl.create(:seat_request, seat: seat1, user: other_user, reason: 'I want this seat') }

    specify 'I can see the reason for the request' do
      visit seats_path
      within(:css, '#sidebar-actions') do
        click_link 'View'
        wait_for_ajax
      end
      within(:css, '.modal') do
        expect(page).to have_content 'I want this seat'
      end
    end

    specify 'I can deny their request' do
      visit seats_path
      within(:css, '#sidebar-actions') do
        click_link 'View'
        wait_for_ajax
      end
      within(:css, '.modal') do
        click_link 'Deny'
      end
      expect(page).to_not have_css('#modalWindow', wait: 5)
      expect(SeatRequest.all.count).to eq(0)
      expect(seat1.user_id).to eq(user.id)
      mail = ActionMailer::Base.deliveries.last
      expect(mail.body).to have_content 'has denied your seat request.'
      expect(mail.to).to have_content other_user.email
    end

    specify 'I can accept their request' do
      visit seats_path
      within(:css, '#sidebar-actions') do
        click_link 'View'
        wait_for_ajax
      end
      within(:css, '.modal') do
        click_link 'Accept'
      end
      expect(page).to_not have_css('#modalWindow', wait: 5)
      expect(SeatRequest.all.count).to eq(0)
      expect(seat1.reload.user_id).to eq(other_user.id)
      mail = ActionMailer::Base.deliveries.last
      expect(mail.body).to have_content 'accepted your seat request.'
      expect(mail.to).to have_content other_user.email
    end
  end
end
