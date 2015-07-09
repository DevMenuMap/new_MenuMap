class MenusController < ApplicationController
	def index
		@menus = Menu.paginate(:page => params[:page], :per_page => 10)
	end

	def create
		@menu = Menu.new(menu_params)
		@restaurant = Restaurant.find(params[:restaurant_id])

		# Only when user select "new menu_title" in the select box.
		if params[:menu][:menu_title_id] == 'new'
			create_menu_title or return
		end

		if @menu.save
			flash[:alert] = "Succeed menu#create"
		else
			@menu.menu_title.update(active: false)
			flash[:alert] = "Fail menu#create"
		end

		redirect_to restaurant_url(@restaurant)
	end

	# GET /menus/:id/edit
	def edit
		@menu = Menu.find(params[:id])
		
		respond_to do |format|
			format.html { redirect_to restaurant_url(@menu.menu_title.restaurant) }
			format.js		{ render layout: false }
		end
	end

	# PUT /menus/:id
	def update
		@menu = Menu.find(params[:id])
		if @menu.update(menu_params)
			flash[:alert] = "Succeed menu#update"
		else
			flash[:alert] = "Fail menu#update"
		end

		respond_to do |format|
			format.html { redirect_to restaurant_url(@menu.menu_title.restaurant) }
			format.js		{ render layout: false }
		end
	end

	def destroy
		@menu = Menu.find(params[:id])
		@menu.update(active: false)
		flash[:alert] = "Succeed menu#destroy"
		redirect_to(:back)
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
end
