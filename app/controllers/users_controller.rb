class UsersController < ApplicationController
	before_action :admin?

  def index
		# @users = User.where("id > 10000000").order(id: :asc)
		@users = User.order(id: :asc)
  end
end
