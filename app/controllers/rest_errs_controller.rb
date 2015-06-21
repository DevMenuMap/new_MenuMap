class RestErrsController < ApplicationController
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
			flash[:alert] = "succeed rest_errs#create"
		else
			flash[:alert] = "fail rest_errs#create"
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

		redirect_to restaurant_path(@rest_err.restaurant)
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

		# Single image update
		# img = params[:rest_err][:pictures_attributes]["0"][:img]
		# @rest_err.pictures.create(img: img)

		# Multiple images update
		# should catch each picture's id and match it
		# if params[:rest_err][:pictures_attributes]["0"][:img]
		# 	0.upto(params.length - 1) do |k|
		# 		img = params[:rest_err][:pictures_attributes]["#{k}"][:img]
		# 		@rest_err.pictures.create(img: img)
		# 	end
		# end
	end

	def destroy
		if @rest_err = RestErr.find(params[:id]).update(active: false)
			flash[:alert] = "succeed rest_err#destroy"
		else
			flash[:alert] = "fail rest_err#destroy"
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
