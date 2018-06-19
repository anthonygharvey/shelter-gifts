desc "This task is called by the Heroku scheduler add-on"
task :reset_shelters => :environment do
  puts "Reseting shelters..."
  Shelter.reset_shelters
  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end