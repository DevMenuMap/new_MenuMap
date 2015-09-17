class Users::RegistrationsController < Devise::RegistrationsController
# before_filter :configure_sign_up_params, only: [:create]
# before_filter :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
		super
  end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
		new_email = current_user.id.to_s + "@menumap.co.kr"
		new_username = "MenuMap_user_" + current_user.id.to_s
		user = User.find(current_user.id)
		user.skip_username_constraints = true

  	if user.update(email: new_email, username: new_username, active: false)
			flash[:success] = "계정을 삭제했습니다."
		else
			flash[:error] = "계정 삭제에 실패했습니다. 다시 한 번 시도해주세요."
		end
		redirect_to root_url
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected
		# When user signed up with omniauth.
		def update_resource(resource, params)
			if current_user.provider == 'facebook'
				params.delete('current_passwrod')
				resource.update_without_password(params)
			else
				resource.update_with_password(params)
			end
		end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.for(:sign_up) << :attribute
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.for(:account_update) << :attribute
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
