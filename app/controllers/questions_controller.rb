class QuestionsController < ApplicationController
	before_action :admin?, except: [:new, :create]

  def index
		@questions = Question.order(created_at: :desc).paginate(page: params[:page], per_page: 20)
  end

	def new
		@question = Question.new
		respond_to do |format|
			format.js { render layout: false }
		end
	end

	def create
		@question = Question.new(question_params)
		@question.user_id = current_user.id if current_user
		if @question.save
			flash[:success] = "질문을 등록했습니다."
		else
			flash[:danger] = "질문 등록에 실패했습니다."
		end
		redirect_to qna_url
	end

	def destroy
		if Question.find(params[:id]).update(active: false)
			flash[:success] = "succeed question#destroy"
		else
			flash[:danger] = "fail questions#destroy"
		end
		redirect_to questions_url
	end

	private
		def question_params
			params.require(:question).permit(:email, :contents)
		end
end
