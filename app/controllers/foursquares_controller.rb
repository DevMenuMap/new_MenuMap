class FoursquaresController < ApplicationController
	def parse
		venue_id = Foursquare.get_venue_id(params[:name], params[:lat], params[:lng])
		@images = Foursquare.get_venue_images(venue_id) if venue_id.present?

		unless @images.blank?
			respond_to do |format|
				format.js { render layout: false }
			end
		end
	end
end
