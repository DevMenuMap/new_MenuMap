class RestErrsController < ApplicationController
	before_action :admin?, :except => [:new, :create]
	
  def index
		@rest_errs = RestErr.paginate(page: params[:page], per_page: 10).order(id: :desc)
  end

  def new 
		@restaurant = Restaurant.find(params[:restaurant_id])
		@rest_err = RestErr.new
		respond_to do |format|
			format.js { render layout: false }
		end
  end

	def create
		@rest_err = RestErr.new(rest_err_params)
		@rest_err.user_id = current_user.id if current_user

		if @rest_err.save
			flash.now[:success] = "음식점 정보 수정 요청이 저장되었습니다."
		else
			flash.now[:danger] = "음식점 정보 수정 요청을 저장하지 못했습니다."
		end

		respond_to do |format|
			format.js { render layout: false }
		end
	end

	def update
		@rest_err = RestErr.find(params[:id])

		if @rest_err.update(active: false, skip: true)
			flash[:success] = "succeed rest_errs#update"
		else
			flash[:danger] = "fail rest_errs#update"
		end

		redirect_to rest_errs_url
	end

	def destroy
		if @rest_err = RestErr.find(params[:id]).update(active: false)
			flash[:success] = "succeed rest_err#destroy"
		else
			flash[:danger] = "fail rest_err#destroy"
		end
		redirect_to rest_errs_url
	end

	private
		def rest_err_params
			params.require(:rest_err).permit(:restaurant_id, :presence_err,
																			 :menu_err, :phnum_err, 
																			 :category_err, :etc, 
																			 :pictures_attributes)
		end
end
