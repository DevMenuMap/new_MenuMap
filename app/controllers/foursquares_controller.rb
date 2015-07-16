class FoursquaresController < ApplicationController
	def parse
		@images = []
		@images << Foursquare.new(username: params[:name], url: "test_url")
		@images << Foursquare.new(username: params[:name], url: "test 2222")

		respond_to do |format|
			format.js
		end
	end
end
