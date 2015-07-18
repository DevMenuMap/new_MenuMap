class MymapsController < ApplicationController
  def index
		@user = User.find(params[:id])
		@mymaps = @user.mymaps

		@coord_array = []
		@mymaps.each do |m|
			@coord_array << m.restaurant.lat.to_f << m.restaurant.lng.to_f
		end

		respond_to do |format|
			format.html
			format.json
		end
  end

	# GET /users/:username/MyMap_list
	def list
		@user = User.find(params[:id])
		@mymaps = @user.mymaps
	end

	def show
		@mymap = Mymap.find(params[:id])
		respond_to_js
	end

	def new
		@mymap = Mymap.new
		@restaurant = Restaurant.find(params[:restaurant_id])
		respond_to_js
	end

	def create
		@restaurant = Restaurant.find(params[:restaurant_id])
		@user = current_user
		@mymap = @restaurant.mymaps.new(mymap_params)
		@mymap.user_id = @user.id
		@mymap.save

		respond_to_js
	end

	def edit
		@mymap = Mymap.find(params[:id])
		respond_to_js
	end

	def update
		@mymap = Mymap.find(params[:id])
		@mymap.update(mymap_params)
		respond_to_js
	end

	def destroy
		@user = current_user
		@mymap = Mymap.find(params[:id])
		@mymap.destroy
		respond_to_js
	end

	private
		def mymap_params
			params.require(:mymap).permit(:rating, :group, :contents)
		end

		def respond_to_js
			respond_to do |format|
				format.js { render layout: false }
			end
		end
end
