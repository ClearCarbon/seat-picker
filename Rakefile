# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

SeatPicker::Application.load_tasks

namespace :seats do
  task clear: :environment do
    Seat.all.each do |seat|
      seat.update_attributes(user_id: nil)
    end

    SeatRequest.destroy_all
  end
end

namespace :users do
  task ensure_usernames: :environment do
    users = User.where('username is null')

    users.each do |user|
      if user.email.include?('@')
        username = user.email.split('@')[0]
        username = username.titleize
      else
        username = 'Anonymous'
      end

      user.username = username
      user.save
    end
  end

  task promote_admin: :environment do
    user_email = ENV['with_email']
    users = User.where(email: user_email)
    users.first.promote_to_admin!
  end

  task demote_admin: :environment do
    user_email = ENV['with_email']
    users = User.where(email: user_email)
    users.first.demote_from_admin!
  end
end
