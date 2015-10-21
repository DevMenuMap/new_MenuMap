class MenuTitlesController < ApplicationController
	before_action :admin?, :except => [:create]
	
  def index
		@menu_titles = MenuTitle.order(id: :desc).paginate(page: params[:page], per_page: 10)
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

  def edit
		@menu_title = MenuTitle.find(params[:id])
  end

	def update
		@menu_title = MenuTitle.find(params[:id])
		if @menu_title.update(menu_title_params)
			flash[:success] = "succeed menu_titles#update"
		else
			flash[:danger]  = "fail menu_titles#update"
		end
		redirect_to menu_titles_path
	end

	def destroy
		@menu_title = MenuTitle.find(params[:id])
		if @menu_title.update(active: false)
			flash[:success] = "succeed menu_titles#destroy"
		else
			flash[:danger]  = "fail menu_titles#destroy"
		end

		# Update all associated menus' active to false 
		@menu_title.menus.each do |m|
			m.update(active: false)
			m.menu_comments.destroy_all if m.menu_comments.exists?
		end

		redirect_to menu_titles_path
	end

	private
		def menu_title_params
			params.require(:menu_title).permit(:restaurant_id, :title_name,
																				 :title_info)
		end
end
