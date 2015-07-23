class MymapSnapshotsController < ApplicationController
	require 'phantomjs'

	def new
		@user = User.find(params[:user_id])		
		respond_to do |format|
			format.js
		end
	end

	def create
		lat = params[:lat]
		lng = params[:lng]
		level = params[:level]
		Phantomjs.run("../new_MenuMap/app/assets/javascripts/snapshot.js", "37.48121", "126.952712", "10", "10")
		redirect_to root_url
	end
	
	def show
		@user = User.find(params[:user_id])
		@mymaps = @user.mymaps

		@lat = params[:lat]
		@lng = params[:lng]
		@level = params[:level]

		@coord_array = []
		@mymaps.each do |m|
			@coord_array << m.restaurant.lat.to_f << m.restaurant.lng.to_f
		end
	end
end
