class MymapSnapshotsController < ApplicationController
	require 'phantomjs'

	def new
		@user = User.find(params[:user_id])		
		respond_to do |format|
			format.js
		end
	end

	def create
		user = User.find(params[:user_id])
		lat = params[:lat]
		lng = params[:lng]
		level = params[:level]
		Phantomjs.run("../new_MenuMap/app/assets/javascripts/snapshot.js", lat, lng, level, current_user.id.to_s)
		file_path = '/home/ec2-user/new_MenuMap/public/images/' + user.id.to_s + '.png'
		if user.mymap_snapshot.blank?
			MymapSnapshot.create(:user => user, :snapshot => File.open(file_path))
		else
			user.mymap_snapshot.update(:snapshot => File.open(file_path))
		end
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
