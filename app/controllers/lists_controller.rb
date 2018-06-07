class ListsController < ApplicationController
	def index
	end

	def new
		@shelter = Shelter.find(params[:shelter_id])
		@list = List.new
	end

	def create
		@shelter = Shelter.find(params[:shelter_id])
		@list = @shelter.lists.build(list_params)
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
	end

	private
	def list_params
		params.require(:list).permit(:name, :description, :url)
	end
end
