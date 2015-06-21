class RestErrsController < ApplicationController
  def index
		@rest_errs = RestErr.all
  end

  def show
		@rest_err = RestErr.find(params[:id])
  end

	def create
		@rest_err = RestErr.new(rest_err_params)
		@rest_err.user_id = current_user.id if current_user

		if @rest_err.save
			flash[:alert] = "succeed rest_errs#create"
		else
			flash[:alert] = "fail rest_errs#create"
		end

		img = params[:rest_err][:pictures_attributes]["0"][:img]
		@rest_err.pictures.create(img: img)

		# if params[:rest_err][:pictures_attributes][:img]
		# 	params[:rest_err][:pictures_attributes][:img].each do |img|
		# 		@rest_err.pictures.create(img: img)
		# 	end
		# end

		# if @rest_err.save
		# 	byebug
		# 	if params[:rest_err][:pictures_attributes][:img]
		# 		params[:rest_err][:pictures_attributes][:img].each do |img|
		# 			@rest_err.pictures.create(img: img)
		# 		end
		# 	end
		# 	flash[:alert] = "succeed rest_errs#create"
		# else
		# 	flash[:alert] = "fail rest_errs#create"
		# end

		redirect_to restaurant_path(@rest_err.restaurant)
	end

  def edit
		@rest_err = RestErr.find(params[:id])
		@rest_err.pictures.build
  end

	def update
		@rest_err = RestErr.find(params[:id])

		img = params[:rest_err][:pictures_attributes]["0"][:img]
		@rest_err.pictures.create(img: img)

		# if params[:rest_err][:pictures_attributes]
		# 	byebug
		# 	params = params[:rest_err][:pictures_attributes]
		# 	0.upto(params.length - 1) do |k|
		# 		img = params[:rest_err][:pictures_attributes]["#{k}"][:img]
		# 		@rest_err.pictures.create(img: img)
		# 	end
		# end

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

	private
		def rest_err_params
			params.require(:rest_err).permit(:restaurant_id, :presence_err,
																			 :menu_err, :phnum_err, 
																			 :category_err, :etc, 
																			 :pictures_attributes)
																			 # pictures_attribute: [:img])
																			 # :pictures_attribute)
		end
end
