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
		Phantomjs.run("../new_MenuMap/lib/assets/javascripts/snapshot.js", lat, lng, level, user.username, user.id.to_s)
		file_path = '/home/ec2-user/new_MenuMap/public/images/' + user.username + '_mymap_snapshot.png'
		if user.mymap_snapshot.blank?
			MymapSnapshot.create(:user => user, :snapshot => File.open(file_path))
		else
			user.mymap_snapshot.update(:snapshot => File.open(file_path))
		end
		File.delete(file_path)

		request_to_fb(user)

		redirect_to mymap_index_url(user.username) 
	end
	
	def show
		@user = User.find(params[:user_id])
		@mymaps = @user.mymaps

		respond_to do |format|
			format.html
			format.json
		end
	end

	private
		def request_to_fb(user)
			fb_id = "http://menumap.co.kr/users/" + user.username + "/MyMap"
			uri = URI.parse("https://graph.facebook.com")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true

			request = Net::HTTP::Post.new(uri.request_uri)
			request.set_form_data({"id" => fb_id, "scrape" => "true"})

			response = http.request(request)
		end
end
