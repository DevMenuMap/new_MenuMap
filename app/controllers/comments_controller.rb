class CommentsController < ApplicationController
	before_action :admin?, :only => [:index]
	
  def index
  	@comments = Comment.all
  end

  def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash[:alert] = "Succeed comment#create"
		else
			flash[:alert] = "Fail comment#create"
		end

		redirect_to_restaurant_page
	end

  def edit
  	@comment = Comment.find(params[:id])
  	if correct_user?(@comment.user)
  		redirect_to_restaurant_page
  	else
  		flash[:alert] = "Wrong user"
  		redirect_to restaurant_url(@comment.restaurant)
  	end
  end

  def update
		@comment = Comment.find(params[:id])

		if correct_user?(@comment.user)
			if @comment.update(comment_params)
				flash[:alert] = "Succeed comment#update"
			else
				flash[:alert] = "Fail comment#update"
			end

			redirect_to_restaurant_page
		else
  		flash[:alert] = "Wrong user"
  		redirect_to restaurant_url(@comment.restaurant)
  	end
	end

  def destroy
		@comment = Comment.find(params[:id])
		if correct_user?(@comment.user)
			@comment.update(active: false)
			flash[:alert] = "Succeed comment#destroy"
			redirect_to_restaurant_page
		else
  		flash[:alert] = "Wrong user"
  		redirect_to restaurant_url(@comment.restaurant), status: 303
  	end
	end

	private
		def comment_params
			params.require(:comment).permit(:restaurant_id, :contents)
		end

		def redirect_to_restaurant_page
			@restaurant = @comment.restaurant
			@comments = @restaurant.comments.paginate(page: params[:page], per_page: 10)

			respond_to do |format|
				format.html	{ redirect_to restaurant_url(@restaurant) }
				format.js		{ render layout: false }
			end
		end
end
