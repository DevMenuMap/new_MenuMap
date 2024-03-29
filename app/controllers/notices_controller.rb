class NoticesController < ApplicationController
	before_action :admin?, :except => [:index]

  def index
		@notices = Notice.all
		@question = Question.new
  end

	def new
		@notice = Notice.new
	end

	def create
		@notice = Notice.new(notice_params)
		if @notice.save
			flash[:alert] = "succeed new notice"
			redirect_to qna_url
		else
			flash[:alert] = "fail new notice"
			redirect_to qna_url
		end
	end

	def edit
		@notice = Notice.find(params[:id])
	end

	def update
		@notice = Notice.find(params[:id])
		if @notice.update_attributes(notice_params) 
			flash[:alert] = "succeed edit notice"
			redirect_to qna_url
		else
			flash[:alert] = "fail edit notice"
			redirect_to qna_url
		end
	end

	def destroy
		@notice = Notice.find(params[:id]).destroy
		flash[:alert] = "succeed destroy notice"
		redirect_to qna_url
	end

	private
		def notice_params
			params.require(:notice).permit(:question, :answer)
		end
end
