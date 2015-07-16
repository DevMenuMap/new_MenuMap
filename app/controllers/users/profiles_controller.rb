class Users::ProfilesController < ApplicationController
	before_action :authenticate_user!

	def edit
		if current_user.username == params[:username]
			@user = User.find_by(username: params[:username])
		else
			flash[:alert] = "잘못된 접근입니다"
			redirect_to root_path
		end
	end
end
