class SessionsController < ApplicationController
	def new
	end

	def create
		if auth = request.env["omniauth.auth"]
			user = User.find_or_create_by(uid: auth['uid']) do |u|
				u.first_name, u.last_name = auth['info']['name'].split(' ')
				if auth['info']['email'] == nil
					u.email = SecureRandom.base64(25) + "@noemail.com"
				else
					u.email = auth['info']['email']
				end
				u.password = SecureRandom.base64(25)
				u.username = SecureRandom.base64(25)
			end
			session[:user_id] = user.id
			if user.shelter == nil
				redirect_to new_user_shelter_path(user)
			else
				redirect_to shelter_path(user.shelter)
			end
		else
			
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
	end

	def destroy
		reset_session
		redirect_to root_path
	end
end
