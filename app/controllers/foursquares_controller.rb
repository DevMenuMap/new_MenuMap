class FoursquaresController < ApplicationController
	def parse
		@images = []
		@images << { name: params[:name], url: "test_url" }	
		@images << { name: params[:name], url: "test_url2" }	

		respond_to do |format|
			format.js
		end
	end
end
