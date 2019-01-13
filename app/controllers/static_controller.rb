class StaticController < ApplicationController
	skip_before_action :authentication_required

	def show
		render params[:page]
	end

	def index
		@all_items = Item.all
		render 'welcome'
	end
end
