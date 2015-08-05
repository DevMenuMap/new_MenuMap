class FranchisesController < ApplicationController
	before_action :admin?
	
  def index
  	@franchises = Franchise.all
		@franchise = Franchise.new
  end

	def show
		@franchise = Franchise.find(params[:id])
	end

  def create
		@franchise = Franchise.new(franchise_params)

		if @franchise.save
			flash[:alert] = "Succeed franchise#create"
		else
			flash[:alert] = "Fail franchise#create"
		end

		redirect_to franchises_url
	end

  def edit
  	@franchise = Franchise.find(params[:id])
  end

  def update
		@franchise = Franchise.find(params[:id])

		if @franchise.update(franchise_params)
			flash[:alert] = "Succeed franchise#update"
		else
			flash[:alert] = "Fail franchise#update"
		end

		redirect_to franchises_url
	end

  def destroy
		@franchise = Franchise.find(params[:id])
		@franchise.destroy
		flash[:alert] = "Succeed franchise#destroy"
		redirect_to franchises_url
	end

	private
		def franchise_params
			params.require(:franchise).permit(:id, :name)
		end
end
