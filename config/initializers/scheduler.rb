require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

scheduler.every '5m' do
	Shelter.reset_shelters
end
