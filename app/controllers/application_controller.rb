class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  before_action :authenticate_user!
  
  def hello
    render text: "Promote Living Starter! Hey yo"
  end
  
  protected
  def configure_permitted_parameters
	devise_parameter_sanitizer.for(:sign_up) << :username
	end
  
end
