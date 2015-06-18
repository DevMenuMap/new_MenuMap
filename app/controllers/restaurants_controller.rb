class RestaurantsController < ApplicationController
	# before_action :check_category, only: [:create]
	# to check if subcategory is not "all thing"; to specify subcategory

  def index
		@restaurants = Restaurant.all
  end

  def show
		@restaurant = Restaurant.find(params[:id])
		@rest_info = RestInfo.unscoped.find(params[:id])  
  end

  def new
		@restaurant = Restaurant.new
		@categories = Category.all
		@subcategories = Subcategory.all
  end

	def create
		@restaurant = Restaurant.new(restaurant_params)
		if @restaurant.save
			flash[:alert] = "succeed restaurants#create"
			# Whenever creating a new Restaurant, create RestInfo also
			create_related_rest_info
			redirect_to restaurants_url
		else
			flash[:alert] = "fail restaurants#create"
			redirect_to :back
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
		redirect_to restaurants_url
	end

	private
		def restaurant_params
			params.require(:restaurant).permit(:name, :addr, :phnum, :delivery,
																				 :category_id, :subcategory_id, 
																				 :menu_on, :open_at)
		end

		def create_related_rest_info
			if RestInfo.create(id: @restaurant.id, restaurant_id: @restaurant.id)
				flash[:alert] += " also succeed rest_infos#create"
			end
		end
end
