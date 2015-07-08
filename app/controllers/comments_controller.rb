class CommentsController < ApplicationController
  def index
  	@comments = Comment.all
  end

  def create
		@comment = Comment.new(comment_params)
		if @comment.save
			flash[:alert] = "Succeed comment#create"
		else
			flash[:alert] = "Fail comment#create"
		end
		redirect_to(:back)
	end

  def edit
  	@comment = Comment.find(params[:id])
  end

  def update
		@comment = Comment.find(params[:id])
		if @comment.update(comment_params)
			flash[:alert] = "Succeed comment#update"
		else
			flash[:alert] = "Fail comment#update"
		end
		redirect_to(:back)
	end

  def destroy
		@comment = Comment.find(params[:id])
		@comment.update(active: false)
		flash[:alert] = "Succeed comment#destroy"
		redirect_to(:back)
	end

	def add_menu
		@comment = Comment.find(params[:id])
	end

	def update_menu
		menu = Menu.find(params[:menu_id])
		comment = Comment.find(params[:id])
		menu_of_comment = MenuComment.new(:menu => menu, :comment => comment)
		if menu_of_comment.save
			flash[:alert] = "Succeed comment#update_menu"
		else
			flash[:alert] = "Fail comment#update_menu"
		end
		redirect_to(:back)
	end

	private
		def comment_params
			params.require(:comment).permit(:restaurant_id,
										 :contents)
		end
end
