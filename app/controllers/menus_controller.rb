class MenusController < ApplicationController
	before_action :admin?, :except => [:create]

	def index
		@menus = Menu.paginate(:page => params[:page], :per_page => 10)
	end

	def create
		# Check if new menu_title is created.
		new_title = false

		@menu = Menu.new(menu_params)
		@menu.user_id = current_user.id if current_user
		@restaurant = Restaurant.find(params[:restaurant_id])

		# Only when user select "new menu_title" in the select box.
		if params[:menu][:menu_title_id] == 'new'
			new_title = true
			create_menu_title or return
		end

		if @menu.save
			flash[:alert] = "Succeed menu#create"
		# If a new menu is invalid, destroy newly created menu_title also.
		elsif new_title == true
			@menu.menu_title.update(active: false)
			flash[:alert] = "fail menu#create and rollback menu_title#create"
		else
			flash[:alert] = "Fail menu#create"
		end

		@menu_titles = @restaurant.menu_titles.reload
		# @menu = Menu.new
		redirect_to_restaurant_page
	end

	# GET /menus/:id/edit
	def edit
		@menu = Menu.find(params[:id])
		redirect_to_restaurant_page
	end

	# PUT /menus/:id
	def update
		@menu = Menu.find(params[:id])

		if @menu.update(menu_params)
			flash[:alert] = "Succeed menu#update"
		else
			flash[:alert] = "Fail menu#update"
		end

		redirect_to_restaurant_page
	end

	# PUT /menus/:id/cancel
	def cancel
		@menu = Menu.find(params[:id])
		redirect_to_restaurant_page
	end

	def destroy
		@menu = Menu.find(params[:id])
		@menu.update(active: false)
		flash[:alert] = "Succeed menu#destroy"

		if destroy_menu_title
			respond_to do |format|
				format.html { redirect_to restaurant_url(@menu_title.restaurant) }
				format.js		{ render action: "destroy_menu_title", layout: false }
			end
		else
			redirect_to_restaurant_page
		end
	end

	private
		def menu_params
			params.require(:menu).permit(:menu_title_id, :name, :side_info,
										 							 :price, :info, :sitga)
		end

		def menu_title_params
			params.require(:menu_title).permit(:title_name, :title_info)
		end

		def create_menu_title
			@menu_title = @restaurant.menu_titles.new(menu_title_params)

			# If fail in creating a new menu_title, return to restaurants#show
			# and stop menus#create.
			unless @menu_title.save
				flash[:alert] = "fail menu_titles#create"
				redirect_to restaurant_url(@restaurant) and return
			end

			# Set menu_title_id to new menu_title's id.
			@menu.menu_title_id = @menu_title.id
		end

		# If there is no menus left after destroy action, delete menu_title.
		def destroy_menu_title
			@menu_title = @menu.menu_title
			no_menu_title = false
			if @menu_title.menus.blank?
				@menu_title.update(active: false)
				no_menu_title = true
			end
		end

		# Redirect to associated restaurant page(Ajax or not)
		def redirect_to_restaurant_page
			@restaurant = @menu.menu_title.restaurant unless @restaurant

			respond_to do |format|
				format.html { redirect_to restaurant_url(@restaurant) }
				format.js		{ render layout: false }
			end
		end
end
