class RestRegistersController < ApplicationController
  def index
  end

  def show
  end

  def new
		@rest_register = RestRegister.new
		@categories = Category.all
		@subcategories = Subcategory.all
  end

	def create
	end

	def destroy
	end
end
