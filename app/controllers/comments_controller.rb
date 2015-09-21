class CommentsController < ApplicationController
	before_action :admin?, only: [:index]
	before_action :correct_user, only: [:edit, :update, :destroy]
	
  def index
  	@comments = Comment.all
  end

	# GET /restaurants/:restaurant_id/comments/more
	# Show more comments in restaurants#show.
	def more
		@restaurant = Restaurant.find(params[:restaurant_id])
		@comments = @restaurant.comments.paginate(page: params[:page], per_page: 10)
		respond_to do |format|
			format.js
		end
	end

  def show
  	@comments = Menu.find(params[:menu_id]).comments
  	if @comments.blank?
  		render :nothing => true
  	else
	  	respond_to do |format|
	  		format.js
	  	end
	  end
  end

  def create
  	double_rating_score

		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id

		if @comment.save
			flash.now[:success] = '댓글을 저장했습니다.' 
		else
			flash.now[:error] = '댓글을 저장하지 못했습니다.' 
		end

		save_menu_comment_tags
		redirect_to_restaurant_page
	end

  def edit
  	@comment = Comment.find(params[:id])
  	if correct_user?(@comment.user)
  		redirect_to_restaurant_page else
  		flash[:alert] = "Wrong user"
  		redirect_to restaurant_url(@comment.restaurant)
  	end
  end

  def update
  	double_rating_score

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
		@comment.active = false
		if @comment.save
			flash.now[:success] = "댓글을 삭제했습니다."
			@comment.menu_comments.destroy_all
		else
  		flash.now[:alert] = "댓글을 삭제하지 못했습니다."
  	end

		respond_to do |format|
			format.js { render layout: false }
		end
	end

	private
		def comment_params
			params.require(:comment).permit(:rating, :restaurant_id, :contents)
		end

		# Double the number to match integer format(1..10)
		def double_rating_score
			params[:comment][:rating] = (params[:comment][:rating].to_f * 2).to_i
		end

		# Save MenuComment tags
		def save_menu_comment_tags 
			if !params[:menu_comments].blank?
				@menus = Restaurant.find(params[:comment][:restaurant_id]).menus
				params[:menu_comments][1..-1].split(',#').each do |tag|
					@menus.find_by_name(tag).menu_comments.create(comment_id: @comment.id)
				end
			end
		end

		def redirect_to_restaurant_page
			@restaurant = @comment.restaurant
			@comments = @restaurant.comments.paginate(page: params[:page], per_page: 10)

			respond_to do |format|
				format.html	{ redirect_to restaurant_url(@restaurant) }
				format.js		{ render layout: false }
			end
		end

  	def correct_user
  		if Comment.find(params[:id]).user != current_user
  			flash.now[:error] = '해당 권한이 없습니다.'
				@no_correct_user = true
				respond_to do |format|
					format.js { render layout: false }
				end
  		end
  	end
end
