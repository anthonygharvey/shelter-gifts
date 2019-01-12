class ItemsController < ApplicationController
	def index
		@all_items = search_items || Item.all
		respond_to do |format|
			format.html {render layout: true}
			format.json { render json: @all_items, include: [:list, "list.shelter"], status: 200 }
		end
	end

	private def search_items
		search = [search_params["city"], search_params["state"], search_params["shelter_type"], search_params["priority"]]

		if search.all?{|s| s == nil}
			@all_items = Item.all
		else
			@shelters = Shelter.all
			@shelters = @shelters.by_city(params["city"]) if params["city"]
			@shelters = @shelters.by_state(params["state"]) if params["state"]
			@shelters = @shelters.by_type(params["shelter_type"]) if params["shelter_type"]
			@all_items = @shelters.collect do |s|
				if (params["priority"] != "" && params["priority"] != nil)
					s.items.select { |i| i.priority == params["priority"].downcase }
				else
					s.items
				end
			end.flatten
		end
	end

	private def search_params
		params.permit(:city, :state, :shelter_type, :priority)
	end
end
