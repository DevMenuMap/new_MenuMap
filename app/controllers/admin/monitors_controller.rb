class Admin::MonitorsController < ApplicationController
	before_action :admin?, :except => [:no_admin]

	def index
		@restaurants = Restaurant.unscoped.all.paginate(page: params[:page], per_page: 10)
	end

	def no_admin
	end
end
