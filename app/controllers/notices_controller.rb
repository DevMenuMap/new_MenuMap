class NoticesController < ApplicationController

  def index
		@notices = Notice.all
  end

	def new
		@notice = Notice.new
	end

	def create
		new_notice = Notice.new(notice_params)
		if new_notice.save
			flash[:alert] = "success new notice"
			redirect_to qna_url
		else
			flash[:alert] = "fail new notice"
			redirect_to qna_url
		end
	end

	def edit
	end

	def update
	end

	def destroy
	end

	private
		def notice_params
			params.require(:notice).permit(:question, :answer)
		end
end
