desc "This task is called by the Heroku scheduler add-on"
task :reset_shelters => :environment do
  puts "Reseting shelters..."
  Shelter.reset_shelters
  puts "done."
end
