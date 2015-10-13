class MymapSnapshotsController < ApplicationController
	require 'phantomjs'

	def show
		@user = User.find(params[:user_id])
		@mymaps = @user.mymaps

		respond_to do |format|
			format.html
			format.json { render layout: false }
		end
	end

	# Only when user updated his MyMap, create a new MyMap screenshot.
	def create
		@user = User.find(params[:user_id])

		Phantomjs.run('../new_MenuMap/lib/assets/javascripts/snapshot.js', @user.id.to_s)
		file_path = '/home/ec2-user/new_MenuMap/public/images/mymap_snapshots/' + @user.id.to_s + '_mymap_snapshot.png'

		@snapshot = MymapSnapshot.find_or_initialize_by(user: @user)
		@snapshot.update(snapshot: File.open(file_path),
										 created_at: @user.mymap_updated_at,
										 updated_at: @user.mymap_updated_at)

		File.delete(file_path)
		request_fb_to_scrape

		respond_to do |format|
			format.js { render layout: false }
		end
	end
	
	private
		# GET call for scraping this page again.
		def request_fb_to_scrape
			url = ENV['CURRENT_IP'] + "/users/#{@user.username}/MyMap"
			uri = URI.parse("https://graph.facebook.com")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true

			request = Net::HTTP::Post.new(uri.request_uri)
			request.set_form_data({"id" => url, "scrape" => "true"})

			response = http.request(request)
		end
end
