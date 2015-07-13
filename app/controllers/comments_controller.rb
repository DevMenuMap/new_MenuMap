class CommentsController < ApplicationController
  def index
  	@comments = Comment.all
  end

  def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id if current_user

		if @comment.save
			flash[:alert] = "Succeed comment#create"
		else
			flash[:alert] = "Fail comment#create"
		end

		redirect_to_restaurant_page
	end

  def edit
  	@comment = Comment.find(params[:id])
  	redirect_to_restaurant_page
  end

  def update
		@comment = Comment.find(params[:id])

		if @comment.update(comment_params)
			flash[:alert] = "Succeed comment#update"
		else
			flash[:alert] = "Fail comment#update"
		end

		redirect_to_restaurant_page
	end

  def destroy
		@comment = Comment.find(params[:id])
		@comment.update(active: false)
		flash[:alert] = "Succeed comment#destroy"
		redirect_to_restaurant_page
	end

	private
		def comment_params
			params.require(:comment).permit(:restaurant_id, :contents)
		end

		def redirect_to_restaurant_page
			@restaurant = @comment.restaurant
			@comments = @restaurant.comments.paginate(:page => params[:page], :per_page => 10)

			respond_to do |format|
				format.html	{ redirect_to restaurant_url(@restaurant) }
				format.js		{ render layout: false }
			end
		end
end
