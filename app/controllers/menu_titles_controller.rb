class MenuTitlesController < ApplicationController
  def index
		@menu_titles = MenuTitle.all.paginate(:page => params[:page], :per_page => 10)
  end

	def create
		@menu_title = MenuTitle.new(menu_title_params)
		if @menu_title.save
			flash[:alert] = "succeed menu_titles#create"
		else
			flash[:alert] = "fail menu_titles#create"
		end
		redirect_to restaurant_path(@menu_title.restaurant)
	end

	# to be called by Ajax on restaurant#show with menu_titles#new
  def edit
		@menu_title = MenuTitle.find(params[:id])
  end

	def update
		@menu_title = MenuTitle.find(params[:id])
		if @menu_title.update(menu_title_params)
			flash[:alert] = "succeed menu_titles#update"
		else
			flash[:alert] = "fail menu_titles#update"
		end
		redirect_to restaurant_path(@menu_title.restaurant)
	end

	def destroy
		@menu_title = MenuTitle.find(params[:id])
		@menu_title.update(active: false)
		flash[:alert] = "succeed menu_titles#destroy"
		redirect_to restaurant_path(@menu_title.restaurant)
	end

	private
		def menu_title_params
			params.require(:menu_title).permit(:restaurant_id, :title_name,
																				 :title_info)
		end
end
