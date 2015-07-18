class MymapsController < ApplicationController
  def index
		@user = User.find(params[:id])
		@mymaps = @user.mymaps
  end

	def show
		@mymap = Mymap.find(params[:id])
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	def new
		@mymap = Mymap.new
		@restaurant = Restaurant.find(params[:restaurant_id])
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@user = current_user
		@mymap = @restaurant.mymaps.new(mymap_params)
		@mymap.user_id = @user.id
		@mymap.save

		respond_to do |format|
			format.js { render layout: false }
		end
	end

	private
		def mymap_params
			params.require(:mymap).permit(:rating, :group, :contents)
		end
end
