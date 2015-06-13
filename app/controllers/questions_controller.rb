class QuestionsController < ApplicationController
	
	# Filters
	before_action :correct_user?, only: [:create]

  def index
		@questions = Question.all
  end

	def create
		@question = Question.new(question_params)
		if @question.save
			flash[:alert] = "succeed question#create"
			redirect_to questions_url
		else
			flash[:alert] = "fail question#create"
			redirect_to questions_url
		end
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
			params.require(:question).permit(:user_id, :email, :contents)
		end

		# Check if the user_id input value is equal to current user's id.
		def correct_user?
			if current_user != User.find(params[:question][:user_id])
				flash[:alert] = "not correct user"
				redirect_to :back
			end
		end
end
