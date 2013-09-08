class SessionsController < ApplicationController

	def new 

	end
	def create
		auth = env["omniauth.auth"]

    	puts auth
		@user = User.from_omniauth(auth)
    	session[:user_id] = @user.id
    	FavoriteFetcher.perform_async(@user.id)
    	redirect_to root_path, :notice => 'Signed in!'
	end

	def destroy
  		session[:user_id] = nil
  		redirect_to landing_path, notice: "Signed out."
	end
end
