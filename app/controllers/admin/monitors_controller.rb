class Admin::MonitorsController < ApplicationController
	before_action :admin?

	def index
		@restaurants = Restaurant.unscoped.all.paginate(page: params[:page], per_page: 10)
	end
end
