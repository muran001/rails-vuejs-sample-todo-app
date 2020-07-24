class Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  skip_before_action :verify_authenticity_token, if: :devise_controller?
  private
  def sign_up_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
  def account_update_params
    params.permit(:name, :email)
  end
end
