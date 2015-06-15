class RestRegistersController < ApplicationController
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
		if @rest_register.save
			flash[:alert] = "succeed in rest_registers#create"
			redirect_to rest_registers_path
		else
			flash[:alert] = "fail in rest_registers#create"
			redirect_to new_rest_register_path
		end
	end

	def destroy
		@rest_register = RestRegister.find(params[:id]).destroy
		flash[:alert] = "succeed in rest_registers#destroy"
		redirect_to :back
	end

	private
		def register_params
			params.require(:rest_register).permit(:user_id, :email, :name,
																						:category_id, :subcategory_id,
																						:addr, :phnum, :delivery,
																						:open_at, :etc)
		end
end
