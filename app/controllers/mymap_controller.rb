class MymapController < ApplicationController
  def index
		@user = User.find(params[:id])
		@restaurants = @user.restaurants
  end
end
