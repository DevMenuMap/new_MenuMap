class MenuCommentsController < ApplicationController
  def index
		@menu = Menu.find(params[:menu_id])
		@comments = @menu.comments.paginate(page: params[:page], per_page: 10)
		respond_to do |format|
			format.js { render layout: false }
		end
  end

	# GET /menus/:menu_id/menu_comments/more
	# Show more comments for that menu.
	def more
		@menu = Menu.find(params[:menu_id])
		@comments = @menu.comments.paginate(page: params[:page], per_page: 10)
		respond_to do |format|
			format.js
		end
	end
end
