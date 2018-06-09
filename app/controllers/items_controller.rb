class ItemsController < ApplicationController
	def index
		@all_items = Item.all # a list of all the items to show on the homepage for regular users
		# @list = List.find(params[:list_id])
		# @items = @list.items
	end
	
end
