class SocialsController < ApplicationController
	# GET socials/share_rest/:restaurant_id
  def share_rest
		@restaurant = Restaurant.find(params[:restaurant_id])
		respond_to do |format|
			format.js { render layout: false }
		end
  end
end
