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

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end

end
