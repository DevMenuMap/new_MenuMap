class RestaurantsController < ApplicationController
	before_action :admin?, :except => [:index, :show, :no_result]
	# before_action :check_category, only: [:create]
	# to check if subcategory is not "all thing"; to specify subcategory

  def index
		@user = current_user
		#@restaurants = []
		#@curr_lat = 0
		#@curr_lng = 0
		#restaurants = Restaurant.search(params[:delivery], params[:category], params[:name], params[:address]).paginate(page: params[:page], per_page: 10)
		@restaurants = Restaurant.search(params[:delivery], params[:category], params[:name], params[:address]).paginate(page: params[:page], per_page: 10)
		
		# Find Center point
		@center_x = 0
		@center_y = 0
		@coord_array = []
		@names = []
		@restaurants.each do |r|
			if( r.lat.to_f != 0 && r.lng.to_f != 0 )
				@coord_array << r.lat.to_f << r.lng.to_f
				@names << r.name
			end
		end
		x = @coord_array.values_at(* @coord_array.each_index.select { |i| i.even? })
		y = @coord_array.values_at(* @coord_array.each_index.select { |i| i.odd? })
		

		# When at least one of lat(and lng) values is not zero
		if( x != [] && y != [] )
			@center_x = (x.inject{|sum, n| sum + n}) / x.length
			@center_y = (y.inject{|sum, n| sum + n}) / y.length
		end

		#### WHEN USE CURRENT POSITION
		#if (params[:curr_pos] == '1')
		#	@curr_lat = params[:lat]
		#	@curr_lng = params[:lng]
		#	# limit 100 & latlng_type = Restaurant
		#	coords = Coordinate.find_by_sql("SELECT id, latlng_id, latlng_type, ( 6371 * acos( cos( radians( #{@curr_lat} ) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians( #{@curr_lng} ) ) + sin( radians( #{@curr_lat} ) ) * sin( radians( lat ) ) ) ) AS distance FROM coordinates HAVING distance < 100 AND latlng_type = 'Restaurant' ORDER BY distance LIMIT 0 , 100")
		#	coords.each do |c|
		#		@restaurants << c.latlng
		#	end
		#else
		#	@restaurants = restaurants
		#end

		if @restaurants.present?
			render 'index'
		else
			render 'no_result'
		end
  end

  def show
		@user = current_user
		@restaurant = Restaurant.find(params[:id])
		@menu_titles = @restaurant.menu_titles
		@comments = @restaurant.comments.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)

		# pictures on this restaurant
		@pictures = @restaurant.pictures

		# partial forms for new objects
		@rest_err = RestErr.new
		@rest_err.pictures.build
		@menu_title = MenuTitle.new
		@menu = Menu.new
		@comment = Comment.new

		# For nearby restaurants 
		@curr_lat = @restaurant.lat.to_f 
		@curr_lng = @restaurant.lng.to_f 
		@nearbyRestaurants = []
		# limit 5 & latlng_type = Restaurant
		coords = Coordinate.find_by_sql("SELECT id, latlng_id, latlng_type, ( 6371 * acos( cos( radians( #{@curr_lat} ) ) * cos( radians( lat ) ) * cos( radians( lng ) - radians( #{@curr_lng} ) ) + sin( radians( #{@curr_lat} ) ) * sin( radians( lat ) ) ) ) AS distance FROM coordinates HAVING distance < 100 AND latlng_type = 'Restaurant' ORDER BY distance LIMIT 0 , 5")
		coords.each do |c|
			@nearbyRestaurants << c.latlng
		end

		respond_to do |format|
			format.html
			# format.json { render json: @comments }
			format.json
			format.js
		end
	end

  def new
		@restaurant = Restaurant.new
		@restaurant.pictures.build

		@categories = Category.all
		@subcategories = Subcategory.all
  end

	def create
		@restaurant = Restaurant.new(restaurant_params)
		if @restaurant.save
			flash[:alert] = "succeed restaurants#create"
			# Whenever creating a new Restaurant, create RestInfo also
			create_rest_info

			# Multiple images upload
			if params[:restaurant][:pictures_attributes]
				params[:restaurant][:pictures_attributes]["0"][:img].each do |img|
					@restaurant.pictures.create(img: img)
				end
			end

			redirect_to restaurant_url(@restaurant)
		else
			flash[:alert] = "fail restaurants#create"
			redirect_to new_restaurant_url
		end
	end

  def edit
		@restaurant = Restaurant.find(params[:id])
		@categories = Category.all
		@subcategories = Subcategory.all
  end

	def update
		@restaurant = Restaurant.find(params[:id])

		# If address is changed, destroy related coordinates, addr_code 
		# and addr_tags.
		@restaurant.destroy_related_when_addr_updated(params)

		if @restaurant.update(restaurant_params)
			flash[:alert] = "succeed restaurants#update"
		else
			flash[:alert] = "fail restaurants#update"
		end

		redirect_to restaurant_url(@restaurant)
	end

	def destroy
		@restaurant = Restaurant.find(params[:id])
		@restaurant.update(active: false)
		# Restaurant.find(params[:id]).update(active: false)
		# inactivate belongings
		inactivate_related
		redirect_to restaurants_url
	end

	private
		def restaurant_params
			params.require(:restaurant).permit(:name, :addr, :phnum, :delivery,
																				 :category_id, :subcategory_id, 
																				 :menu_on, :open_at, :pictures)
		end

		def inactivate_related
			@restaurant.rest_info.coordinate.destroy if @restaurant.rest_info.coordinate.present? 
			@restaurant.rest_info.update(active: false)
			@restaurant.coordinate.destroy if @restaurant.coordinate.present?
		end

		def create_rest_info
			@restaurant.create_rest_info(id: @restaurant.id)
		end
end
