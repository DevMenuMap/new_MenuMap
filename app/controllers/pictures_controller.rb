class PicturesController < ApplicationController
  def index
		@pictures = Picture.all
  end

  def show
  end

  def new
		@picture = Picture.new
  end

	def create
		@picture = Picture.new(picture_params)
		if @picture.save
			flash[:alert] = "succeed pictures#create"
			redirect_to pictures_url
		else
			flash[:alert] = "fail pictures#create"
			redirect_to new_picture_url
		end
	end

  def edit
  end

	def update
	end

	def destroy
	end

	private
		def picture_params
			params.require(:picture).permit(:img)
		end
end
