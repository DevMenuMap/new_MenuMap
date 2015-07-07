class MenusController < ApplicationController
	def index
		@menus = Menu.paginate(:page => params[:page], :per_page => 10)
	end

	def create
		@menu = Menu.new(menu_params)
		if @menu.save
			flash[:alert] = "Succeed menu#create"
		else
			flash[:alert] = "Fail menu#create"
		end
		redirect_to(:back)
	end

	def edit
		@menu = Menu.find(params[:id])
	end

	def update
		@menu = Menu.find(params[:id])
		if @menu.update(menu_params)
			flash[:alert] = "Succeed menu#update"
		else
			flash[:alert] = "Fail menu#update"
		end
		redirect_to(:back)
	end

	def destroy
		@menu = Menu.find(params[:id])
		@menu.update(active: false)
		flash[:alert] = "Succeed menu#destroy"
		redirect_to(:back)
	end

	private
		def menu_params
			params.require(:menu).permit(:name, :side_info,
										 							 :price, :info, :sitga)
		end
end
