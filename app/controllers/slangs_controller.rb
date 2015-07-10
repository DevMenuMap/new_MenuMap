class SlangsController < ApplicationController
	def index
		@slangs = Slang.all
	end

	def new
		@slang = Slang.new
	end

	def create
		@slang = Slang.new(slang_params)
		if @slang.save
			flash[:alert] = "Succeed slang#create"
		else
			flash[:alert] = "Fail slang#create"
		end
		redirect_to slang_url(@slang)
	end

	def show
		@slang = Slang.find(params[:id])
	end

	def edit
		@slang = Slang.find(params[:id])
	end

	def update
		@slang = Slang.find(params[:id])
		if @slang.update(slang_params)
			flash[:alert] = "Succeed slang#update"
		else
			flash[:alert] = "Fail slang#update"
		end
		redirect_to slang_url(@slang)
	end

	def destroy
		@slang = Slang.find(params[:id])
		@slang.update(active: false)

		flash[:alert] = "Succeed slang#destroy"
		
		redirect_to slangs_url
	end

	private
		def slang_params
			params.require(:slang).permit(:name)
		end
end
