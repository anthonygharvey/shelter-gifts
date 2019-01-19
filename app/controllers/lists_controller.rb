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
		if @list.valid?
		@list.get_items(@list.url)
		@list.items.each{|item| item.valid? ? next : item.delete}
		@list.save
		@list.reload
		render json: @list
		# if @list.valid? && @list.save
		# redirect_to list_path(@list)
		else
			render "new"
		end
	end

	def show
		render json: @list = List.find(params[:id])
	end

	def edit
	end

	def update
	end

	def destroy
		@list = List.find(params[:id])
		@list.destroy
		redirect_to shelter_path(@current_user.shelter)
	end

	private
	def list_params
		params.require(:list).permit(:name, :description, :url)
	end
end
