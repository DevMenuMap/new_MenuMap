class UsersController < ApplicationController
	before_action :admin?

  def index
		@users = User.where("id > 10000000").order(id: :asc)
		@deleted_users = User.unscoped.where("active = 0").order(updated_at: :desc)
  end
end
