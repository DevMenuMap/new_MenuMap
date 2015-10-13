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

	def create
		@user = User.find(params[:user_id])

		# If user updated mymap, params is true.
		if params[:update] == 'true'
			Phantomjs.run('../new_MenuMap/lib/assets/javascripts/snapshot.js', @user.id.to_s)
			file_path = '/home/ec2-user/new_MenuMap/public/images/mymap_snapshots/' + @user.id.to_s + '_mymap_snapshot.png'

			@snapshot = MymapSnapshot.find_or_initialize_by(user: @user)
			@snapshot.update(snapshot: File.open(file_path),
											 created_at: @user.mymap_updated_at,
											 updated_at: @user.mymap_updated_at)

			File.delete(file_path)
			# request_to_fb
		else
			# Just send fb to get url	
		end

		redirect_to mymap_index_url(@user.username) 
	end
	
	private
		def request_to_fb
			fb_id = "http://menumap.co.kr/users/" + @user.username + "/MyMap"
			uri = URI.parse("https://graph.facebook.com")
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true

			request = Net::HTTP::Post.new(uri.request_uri)
			request.set_form_data({"id" => fb_id, "scrape" => "true"})

			response = http.request(request)
		end
end
