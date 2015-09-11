class RestErrsController < ApplicationController
	before_action :admin?, :except => [:create, :modal]
	
  def index
		@rest_errs = RestErr.all
  end

  def show
		@rest_err = RestErr.find(params[:id])
		@pictures = @rest_err.pictures
  end

	def create
		@rest_err = RestErr.new(rest_err_params)
		@rest_err.user_id = current_user.id if current_user

		if @rest_err.save
			flash.now[:success] = "음식점 정보 수정 요청이 저장되었습니다."
		else
			flash.now[:danger] = "음식점 정보 수정 요청을 저장하지 못했습니다."
		end

		# Single image upload
		# img = params[:rest_err][:pictures_attributes]["0"][:img]
		# @rest_err.pictures.create(img: img)

		# Multiple images upload
		if params[:rest_err][:pictures_attributes]
			params[:rest_err][:pictures_attributes]["0"][:img].each do |img|
				@rest_err.pictures.create(img: img)
			end
		end

		respond_to do |format|
			format.js { render layout: false }
		end
	end

  def edit
		@rest_err = RestErr.find(params[:id])
		@rest_err.pictures.build
  end

	def update
		@rest_err = RestErr.find(params[:id])

		if @rest_err.update(rest_err_params)
			flash[:alert] = "succeed rest_errs#update"
		else
			flash[:alert] = "fail rest_errs#update"
		end

		redirect_to rest_errs_url
	end

	def destroy
		if @rest_err = RestErr.find(params[:id]).update(active: false)
			flash[:alert] = "succeed rest_err#destroy"
		else
			flash[:alert] = "fail rest_err#destroy"
		end
		redirect_to rest_errs_url
	end

	# GET /rest_errs/:id/modal
	def modal
		@restaurant = Restaurant.find(params[:id])
		@rest_err = RestErr.new
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	private
		def rest_err_params
			params.require(:rest_err).permit(:restaurant_id, :presence_err,
																			 :menu_err, :phnum_err, 
																			 :category_err, :etc, 
																			 :pictures_attributes)
		end
end
