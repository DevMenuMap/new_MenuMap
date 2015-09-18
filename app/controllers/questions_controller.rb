class QuestionsController < ApplicationController
  def index
		@questions = Question.all
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

  def edit
		@question = Question.find(params[:id])
  end

	def update
		@question = Question.find(params[:id])
		if @question.update_attributes(question_params)
			flash[:alert] = "succeed question#update"
			redirect_to questions_url
		else
			flash[:alert] = "fail question#update"
			redirect_to questions_url
		end
	end

	def destroy
		@question = Question.find(params[:id]).destroy
		flash[:alert] = "succeed question#delete"
		redirect_to questions_url
	end

  def show
		@question = Question.find(params[:id])
  end

	private
		def question_params
			params.require(:question).permit(:email, :contents)
		end
end
