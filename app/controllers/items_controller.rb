class ItemsController < ApplicationController
	def index
		if params["shelter"]
			@shelters = Shelter.all
				if params["shelter"]["city"]
					@shelters = @shelters.by_city(params["shelter"]["city"])
				end
				if params["shelter"]["state"]
					@shelters = @shelters.by_state(params["shelter"]["state"])
				end
				if params["shelter"]["shelter_type"]
					@shelters = @shelters.by_type(params["shelter"]["shelter_type"])
				end
			@all_items = @shelters.collect do |s|
				if params["priority"] != ""
					s.items.select do |i|
						i.priority == params["priority"].downcase
					end
				else
					s.items
				end
			end.flatten
		else
			@all_items = Item.all
		end
	
	end

end
