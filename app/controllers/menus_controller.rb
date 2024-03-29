class MenusController < ApplicationController
	before_action :admin?, except: [:create]

	def index
		@menus = Menu.paginate(page: params[:page]).order(id: :desc)
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
			flash.now[:success] = "새로운 메뉴를 추가했습니다."

			# Update menu_on and @first_menu_created.
			update_associates

		# If a new menu is invalid, destroy newly created menu_title also.
		elsif new_title == true
			@menu.menu_title.update(active: false)
			flash.now[:danger] = "메뉴 정보가 잘못되었습니다."
		else
			flash.now[:danger] = "메뉴 정보가 잘못되었습니다."
		end

		@menu_titles = @restaurant.menu_titles.reload
		redirect_to_restaurant_page
	end

	# GET /menus/:id/edit
	def edit
		@menu = Menu.find(params[:id])
	end

	# PUT /menus/:id
	def update
		@menu = Menu.find(params[:id])
		@menu.price = nil	unless params[:menu][:price]
		if @menu.update(menu_params)
			flash[:success] = "Succeed menu#update"
		else
			flash[:danger] = "Fail menu#update"
		end
		redirect_to menus_url
	end

	# PUT /menus/:id/cancel
	def cancel
		@menu = Menu.find(params[:id])
		redirect_to_restaurant_page
	end

	def destroy
		@menu = Menu.find(params[:id])
		if @menu.update(active: false)
			@menu.menu_comments.destoy_all if @menu.menu_comments.exists?
			flash[:success] = "Succeed menus#destroy"
		else
			flash[:danger] = "Fail menus#destroy"
		end
		redirect_to menus_url
	end

	private
		def menu_params
			params.require(:menu).permit(:menu_title_id, :name, :side_info,
										 							 :price, :info, :sitga, :unidentified)
		end

		def menu_title_params
			params.require(:menu_title).permit(:title_name, :title_info)
		end

		def create_menu_title
			@menu_title = @restaurant.menu_titles.new(menu_title_params)

			# If fail in creating a new menu_title, return to restaurants#show
			# and stop menus#create.
			unless @menu_title.save
				flash.now[:danger] = "메뉴 목록이 잘못되었습니다."
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

		def update_associates
			# Update menu_on when the new menu is the first one.
			unless @restaurant.menu_on > 0 
				@restaurant.update(menu_on: 1) 
				@first_menu_created = true
			end

			@restaurant.rest_info.update(menu_updated_at: Time.now)
		end
end
