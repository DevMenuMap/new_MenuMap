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
		@picture = Picture.find(params[:id])
  end

	def update
		@picture = Picture.find(params[:id])
		if @picture.update(picture_params)
			flash[:alert] = "succeed pictures#update"
		else
			flash[:alert] = "fail pictures#update"
		end
		redirect_to rest_err_url(@picture.imageable)
	end

	def destroy
		if Picture.find(params[:id]).update(active: false)
			flash[:alert] = "succeed pictures#destroy"
		else
			flash[:alert] = "fail pictures#destroy"
		end
		redirect_to :back
	end

	private
		def picture_params
			params.require(:picture).permit(:img)
		end
end
