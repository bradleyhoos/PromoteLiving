class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :find_user
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end

  def find_user
    return if devise_controller?
    if current_user.present?
      @user = current_user
    else
      if session['warden.user.user.key']
        @user = User.find(session['warden.user.user.key'][0].try(:first)) ?
          User.find(session['warden.user.user.key'][0].try(:first)) : nil
      else
        sign_out
      end
    end
  end

  def hello
    render text: "Promote Living Starter! Hey yo"
  end

  def after_sign_in_path_for(resource)
    dashboard_path || root_path
    # (check_for_complete_account ? dashboard_path : new_insurance_path) || root_path
  end

  def after_sign_up_path_for(resource)
    dashboard_path || root_path
    # (check_for_complete_account ? dashboard_path : new_insurance_path) || root_path
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) do |u|
      u.permit(:first_name, :last_name, :email, :password,
               :current_password, :password_confirmation, :preffered_name)
    end
    # devise_parameter_sanitizer.for(:account_update) do |u|
    #   u.permit(:first_name, :last_name, :email, :password,
    #            :current_password, :password_confirmation, :preffered_name)
    # end
  end

end
