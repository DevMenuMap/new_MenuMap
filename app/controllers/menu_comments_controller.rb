class MenuCommentsController < ApplicationController
  def index
		@menu = Menu.find(params[:menu_id])
		@comments = @menu.comments
		respond_to do |format|
			format.js { render layout: false }
		end
  end
end
