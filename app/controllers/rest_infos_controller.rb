class RestInfosController < ApplicationController
	before_action :admin?

  def new
		@restaurant = Restaurant.find(params[:restaurant_id])
		@rest_info = RestInfo.new
  end

	def create
		@rest_info = RestInfo.new(rest_info_params)
		@rest_info.id = @rest_info.restaurant_id = params[:restaurant_id]
		if @rest_info.save
			flash[:alert] = "succeed rest_infos#create"
			redirect_to restaurant_path(params[:restaurant_id])
		else
			flash[:alert] = "fail rest_infos#create"
			redirect_to restaurant_path(params[:restaurant_id])
		end
	end

  def edit
		@rest_info = RestInfo.unscoped.find(params[:id])
  end

	def update
		@rest_info = RestInfo.unscoped.find(params[:id])
		if @rest_info.update(rest_info_params)
			flash[:alert] = "succeed rest_infos#update"
			redirect_to restaurant_path(params[:id])
		else
			flash[:alert] = "fail rest_infos#update"
			redirect_to restaurant_path(params[:id])
		end
	end

	def destroy
		RestInfo.find(params[:id]).update(active: false)
		redirect_to :back
	end

	private
		def rest_info_params
			params.require(:rest_info).permit(:owner_intro, :active)
		end
end
