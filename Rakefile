# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

SeatPicker::Application.load_tasks

namespace :seats do
  task :clear => :environment do
    seats = Seat.all;
    seats.each do |seat|
      seat.update_attributes(user_id: nil)
    end
  end
end

namespace :users do
  task :ensure_usernames => :environment do
    users = User.where('username is null');

    users.each do |user|

      if(user.email.include?('@'))
        username = user.email.split('@')[0];
        username = username.titleize
      else
        username = 'Anonymous'
      end

      user.username = username
      user.save
    end
  end
end
