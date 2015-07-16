class MymapController < ApplicationController
  def index
		@user = User.find(params[:id])
		@mymaps = @user.mymaps
  end

	def show
		@mymap = Mymap.find(params[:id])
		respond_to do |format|
			format.js { render layout: false }
		end
	end
end
