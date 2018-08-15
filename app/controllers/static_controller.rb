class StaticController < ApplicationController
	skip_before_action :authentication_required

	def show
		render params[:page]
	end
end
