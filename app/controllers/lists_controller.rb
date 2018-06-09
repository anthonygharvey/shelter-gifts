class ListsController < ApplicationController
	def index
		@shelter = Shelter.find(params[:shelter_id])
		@lists = @shelter.lists
		
	end

	def new
		@shelter = Shelter.find(params[:shelter_id])
		@list = List.new
	end

	def create
		@shelter = Shelter.find(params[:shelter_id])
		@list = @shelter.lists.build(list_params)
		@list.get_items(@list.url)
		if @list.save
			redirect_to list_path(@list)
		else
			render "new"
		end
	end

	def show
		@list = List.find(params[:id])
	end

	def edit
	end

	def update
	end

	def destroy
		@list = List.find(params[:id])
		@list.items.each do |item|
			item.delete
		end
		@list.delete
		redirect_to shelter_path(@current_user.shelter)
	end

	private
	def list_params
		params.require(:list).permit(:name, :description, :url)
	end
end
