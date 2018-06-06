class SheltersController < ApplicationController
	def index
	end

	def new
		@shelter = Shelter.new
	end

	def create
		@shelter = Shelter.new
		@shelter.name = params[:shelter][:name]
		@shelter.city = params[:shelter][:city]
		@shelter.state = params[:shelter][:state]
		@shelter.ein = params[:shelter][:ein]
		@shelter.shelter_type = params[:shelter][:shelter_type]
		@shelter.description = params[:shelter][:description]
		@shelter.website_url = params[:shelter][:website_url]
		@shelter.save
		binding.pry
		redicrect_to shelter_path(@shelter)
	end
	
	def show
		@shelter = Shelter.find(params[:id])
	end

	def edit
	end

	def update
	end

	def destroy
	end
end
