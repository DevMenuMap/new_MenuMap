class CommentsController < ApplicationController
	before_action :admin?, only: [:index]
	before_action :correct_user, only: [:edit, :update, :destroy]
	before_action :double_rating_score, only: [:create, :update]
	
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

  def create
		@comment = Comment.new(comment_params)
		@comment.user_id = current_user.id
		@restaurant = @comment.restaurant

		if @comment.save
			flash.now[:success] = '댓글을 저장했습니다.' 
			save_menu_comment_tags
		else
			flash.now[:error] = '댓글을 저장하지 못했습니다.' 
		end

		respond_to do |format|
			format.js { render layout: false }
		end
	end

  def edit
  	@comment = Comment.find(params[:id])
		respond_to do |format|
			format.js	{ render layout: false }
		end
  end

  def update
		@comment = Comment.find(params[:id])

		if @comment.update(comment_params)
			flash.now[:success] = '댓글을 수정했습니다.'
			save_menu_comment_tags
		else
			flash.now[:error] = '댓글을 수정하지 못했습니다.'
		end

		respond_to do |format|
			format.js { render layout: false }
		end
	end

	def cancel
		@comment = Comment.find(params[:id])
		respond_to do |format|
			format.js { render layout: false }
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
			menu_comments = @comment.menu_comments.pluck(:id)

			unless params[:menu_comments].blank?
				menus = @comment.restaurant.menus
				params[:menu_comments][1..-1].split(',#').each do |tag|
					# Only when the tag's menu name is correct.
					if menu = menus.find_by_name(tag)
						menu_comments -= [ MenuComment.find_or_create_by(menu: menu, comment: @comment).id ]
					end
				end
			end

			# Destroy remaining menu_comment_tags.
			# These tags were removed when editing.
			MenuComment.where("id in (?)", menu_comments).destroy_all
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
