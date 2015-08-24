class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end

  private
  	def correct_user
  		@user = User.find_by(username: params[:username])
  		if @user != current_user
  			flash[:alert] = "Wrong user"
  			redirect_to(root_url) 
  		end
  	end

    def admin?
      if !current_user || current_user.admin == false
        redirect_to '/422.html' and return
      end 
    end

    def correct_user?(user)
      (user.nil? || current_user.nil? || !current_user.admin || current_user.id != user.id)? false : true
    end
end
