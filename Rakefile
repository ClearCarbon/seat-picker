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
