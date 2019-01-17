class ItemsController < ApplicationController
	def index
		@all_items = search_items || Item.all
	end

	private def search_items
		search = [params[:city], params[:state], params[:type], params[:priority]]
		test = if search.all?{|s| s == nil}
			@all_items = Item.all
		else
			@shelters = Shelter.all
				.by_city(params[:city])
				.by_state(params[:state])
				.by_type(params[:shelter_type])
				
			@all_items = @shelters.collect do |s|
				if (params[:priority] != "" && params[:priority] != nil)
					s.items.select { |i| i.priority == params[:priority].downcase }
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
