class MymapsController < ApplicationController
  def index
		@user = User.find_by(username: params[:username])
		@mymaps = @user.mymaps
		@groups = []
		@coord_array = []
		@names = []
		
		@mymaps.each do |m|
			# Check restaurant's lat,lng nil?
			if( m.restaurant.lat.to_f != 0 && m.restaurant.lng.to_f != 0 )
				@coord_array << m.restaurant.lat.to_f << m.restaurant.lng.to_f
				@groups << m.group
				@names << m.restaurant.name
			end
		end

		# Find Center point
		y = []
		x = []
		@center_y = 0
		@center_x = 0
		
		if( @coord_array != [] )
			l = @coord_array.length / 2
			for i in 0..(l-1)
				y << @coord_array[2*i]
				x << @coord_array[2*i+1]
			end
			x.uniq!
			y.uniq!

			@center_x = (x.inject{|sum, n| sum + n}) / x.length
			@center_y = (y.inject{|sum, n| sum + n}) / y.length
		end

		respond_to do |format|
			format.html
			format.json
		end
  end

	# GET /users/:username/MyMap_list
	def list
		@user = User.find_by(username: params[:username])
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
		double_rating_score
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
		double_rating_score
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

		# Double the number to match integer format(1..10)
		def double_rating_score
			params[:mymap][:rating] = (params[:mymap][:rating].to_f * 2).to_i
		end
end
