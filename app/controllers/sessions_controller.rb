class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by(:email => params[:email])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			if user.shelter == nil
				redirect_to new_user_shelter_path(user)
			else
				redirect_to shelter_path(user.shelter)
			end
		else
			render "sessions/new"
		end
	end

	def destroy
		reset_session
		redirect_to root_path
	end
end
