class RestInfosController < ApplicationController
  def new
		@rest_info = RestInfo.new
  end

	def create
		puts params[:rest_info][:naver_lat]
		puts params[:rest_info][:naver_lat].class
		@rest_info = RestInfo.new(rest_info_params)
		@rest_info.restaurant_id = 6
		if @rest_info.save
			flash[:alert] = "succeed rest_infos#create"
			redirect_to :back
		else
			flash[:alert] = "fail rest_infos#create"
			redirect_to :back
		end
	end

  def edit
		@rest_info = RestInfo.find(params[:id])
  end

	def update
		@rest_info = RestInfo.find(params[:id])
		if @rest_info.update(rest_info_params)
			flash[:alert] = "succeed rest_infos#update"
			redirect_to :back
		else
			flash[:alert] = "fail rest_infos#update"
			redirect_to :back
		end
	end

	def destroy
		RestInfo.find(params[:id]).update(active: false)
		redirect_to :back
	end

	private
		def rest_info_params
			params.require(:rest_info).permit(:id, :restaurant_id, :owner_intro,
																				:naver_lat, :naver_lng)
		end
end
