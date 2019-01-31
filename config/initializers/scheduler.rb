require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

scheduler.every '30m' do
	Shelter.reset_shelters
end
