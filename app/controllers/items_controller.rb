class ItemsController < ApplicationController
	def index
		search = [params["city"], params["state"], params["shelter_type"], params["priority"]]
		if search.all?{|s| s == nil}
			@all_items = Item.all
		else
			@shelters = Shelter.all
				if params["city"]
					@shelters = @shelters.by_city(params["city"])
				end
				if params["state"]
					@shelters = @shelters.by_state(params["state"])
				end
				if params["shelter_type"]
					@shelters = @shelters.by_type(params["shelter_type"])
				end
			@all_items = @shelters.collect do |s|
				if (params["priority"] != "" && params["priority"] != nil)
					s.items.select do |i|
						i.priority == params["priority"].downcase
					end
				else
					s.items
				end
			end.flatten
		end
		
	
	end

end
