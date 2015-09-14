class RestRegistersController < ApplicationController
	before_action :admin?, :except => [:new, :create]

  def index
		@rest_registers = RestRegister.all
  end

  def show
		@rest_register = RestRegister.find(params[:id])
  end

  def new
		@rest_register = RestRegister.new

		@categories = Category.all
		@subcategories = Subcategory.all
  end

	def create
		@rest_register = RestRegister.new(register_params)	
		@rest_register.user_id = current_user.id if current_user
		if @rest_register.save
			flash[:success] = "음식점 추가 신청이 완료되었습니다."
		else
			flash[:danger] = "음식점 추가 신청에 실패했습니다."
		end
		redirect_to new_rest_register_url
	end

	def destroy
		@rest_register = RestRegister.find(params[:id]).destroy
		flash[:alert] = "succeed in rest_registers#destroy"
		redirect_to :back
	end

	private
		def register_params
			params.require(:rest_register).permit(:email, :name,
																						:category_id, :subcategory_id,
																						:addr, :phnum, :delivery,
																						:open_at, :etc, :pictures)
		end
end
