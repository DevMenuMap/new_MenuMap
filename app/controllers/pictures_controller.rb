class PicturesController < ApplicationController
	before_action :admin?, except: :create
	
  def index
		@pictures = Picture.where("imageable_type = 'Restaurant' AND user_id IS NULL").order(id: :desc).paginate(page: params[:page])
  end

  def show
  end

  def new
		@picture = Picture.new
  end

	def create
		params[:picture][:img].each do |img|
			@picture = Picture.new(img: img)
			@picture.attributes = picture_params
			if @picture.save
				flash[:success] = '사진을 저장했습니다.'
				@picture.imageable.rest_info.update(img_updated_at: Time.now) if @picture.imageable_type == 'Restaurant'
			else
				flash[:danger] = '사진 저장에 실패했습니다.'
			end
		end

		redirect_to :back
	end

  def edit
		@picture = Picture.find(params[:id])
  end

	def update
		@picture = Picture.find(params[:id])
		if @picture.update(img: params[:picture][:img])
			flash[:alert] = "succeed pictures#update"
		else
			flash[:alert] = "fail pictures#update"
		end
		redirect_to pictures_url
	end

	def destroy
		if Picture.find(params[:id]).update(active: false)
			flash[:success] = "succeed pictures#destroy"
		else
			flash[:danger] = "fail pictures#destroy"
		end
		redirect_to :back
	end

	private
		def picture_params
			params.require(:picture).permit(:imageable_type, :imageable_id, 
																			:user_id)
		end
end
