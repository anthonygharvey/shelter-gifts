class SheltersController < ApplicationController
	def index
	end

	def new
		@user = User.find(params[:user_id])
		@shelter = Shelter.new
	end

	def create
		@shelter = current_user.build_shelter(shelter_params)
		prepend_http(@shelter.website_url)
		if @shelter.save
			redirect_to shelter_path(@shelter)
		else
			render "new"
		end

	end
	
	def show
		@shelter = current_user.shelter
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
	def shelter_params
		params.require(:shelter).permit(:name, :city, :state, :ein, :shelter_type, :description, :website_url)
	end

	def prepend_http(url)
		if url != "" && url.match(/http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\//) == nil
			url.prepend("http://")
		end
	end
end
