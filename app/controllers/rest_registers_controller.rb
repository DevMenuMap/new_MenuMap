class RestRegistersController < ApplicationController
	before_action :admin?, :except => [:new, :create]

  def index
		@rest_registers = RestRegister.all
  end

  def show
		@rest_register = RestRegister.find(params[:id])
  end

  def new
		flash[:alert] = "더 정확하고 많은 정보를 제공해주시면 음식점 정보를 빠르게 등록할 수 있습니다."
		@rest_register = RestRegister.new
		@rest_register.pictures.build

		@categories = Category.all
		@subcategories = Subcategory.all
  end

	def create
		@rest_register = RestRegister.new(register_params)	
		@rest_register.user_id = current_user.id if current_user
		if @rest_register.save
			flash[:alert] = "succeed in rest_registers#create"

			# Multiple images upload
			if params[:rest_register][:pictures_attributes]
				params[:rest_register][:pictures_attributes]["0"][:img].each do |img|
					@rest_register.pictures.create(img: img)
				end
			end

			redirect_to rest_registers_url
		else
			flash[:alert] = "fail in rest_registers#create"
			redirect_to new_rest_register_url
		end
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
