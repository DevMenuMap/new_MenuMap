class RestaurantsController < ApplicationController
	# before_action :check_category, only: [:create]
	# to check if subcategory is not "all thing"; to specify subcategory

  def index
		@restaurants = Restaurant.all.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		@restaurant = Restaurant.find(params[:id])
		# change to this after creating all RestInfo
		# @rest_info = RestInfo.find(params[:id])  
		@rest_info = RestInfo.unscoped.find(params[:id])  
		@menu_titles = @restaurant.menu_titles
		@menus = @restaurant.menus

		# partial forms
		@rest_err = RestErr.new
		@rest_err.pictures.build
		@menu_title = MenuTitle.new
		@menu = Menu.new
		@comment = Comment.new

		# pictures on this restaurant
		@pictures = @restaurant.pictures
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
			RestInfo.create(id: @restaurant.id, restaurant_id: @restaurant.id)

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
		if @restaurant.update(restaurant_params)
			flash[:alert] = "succeed restaurants#update"
			redirect_to restaurants_url(@restaurant)
		else
			flash[:alert] = "fail restaurants#update"
			redirect_to :back
		end
	end

	def destroy
		Restaurant.find(params[:id]).update(active: false)
		# inactivate belongings
		redirect_to restaurants_url
	end

	private
		def restaurant_params
			params.require(:restaurant).permit(:name, :addr, :phnum, :delivery,
																				 :category_id, :subcategory_id, 
																				 :menu_on, :open_at, :pictures)
		end
end
