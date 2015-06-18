class RestErrsController < ApplicationController
  def index
		@rest_errs = RestErr.all
  end

  def show
		@rest_err = RestErr.find(params[:id])
  end

	def create
		@rest_err = RestErr.new(create_rest_err_params)
		@rest_err.user_id = current_user.id if current_user
		if @rest_err.save
			flash[:alert] = "succeed rest_errs#create"
		else
			flash[:alert] = "fail rest_errs#create"
		end
		redirect_to restaurant_path(@rest_err.restaurant)
	end

  def edit
		@rest_err = RestErr.find(params[:id])
  end

	def update
		@rest_err = RestErr.find(params[:id])
		if @rest_err.update(edit_rest_err_params)
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
		def create_rest_err_params
			params.require(:rest_err).permit(:restaurant_id, :presence_err,
																			 :menu_err, :phnum_err, 
																			 :category_err, :etc)
		end
		def edit_rest_err_params
			params.require(:rest_err).permit(:restaurant_id, :presence_err,
																			 :menu_err, :phnum_err, 
																			 :category_err, :etc, :active)
		end
end
