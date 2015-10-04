class ApplicationController < ActionController::Base
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :find_user
  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, alert: exception.message
  end

  rescue_from Rack::Timeout::RequestTimeoutError,
    Rack::Timeout::RequestExpiryError, with: :handle_request_timeout

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

  def check_for_complete_account
    # if user_signed_in?
      if current_user.is_insured?
        check_for_hsa #check_for_rewards_cards
      else
        redirect_to new_insurance_path, notice: 'Please add your insurance information.' and return
      end
    # end
  end

  def check_for_hsa
    if current_user.has_hsa?
      check_for_rewards_cards
      # redirect_to dashboard_path, notice: "Congratulations! You're ready to earn rewards for healthy purchases!" and return
    else
      redirect_to new_health_savings_account_path, notice: 'Please add your insurance information.' and return
    end
  end

  def check_for_rewards_cards
    if current_user.has_rewards_cards?
      redirect_to dashboard_path, notice: "Congratulations! You're ready to earn rewards for healthy purchases!" and return
    else
      redirect_to rewards_card_chooser_path, notice: 'Please add a rewards card.' and return
      # redirect_to new_rewards_card_path, notice: 'Please add a rewards card.' and return
    end
  end

  private
  def handle_request_timeout(_)
    # If there is no accepted format declared by controller
    respond_to do |format|
      format.html do
        render file: Rails.root.join("public/503.html"),
          status: 503, layout: nil
      end
      format.all  { head 503 }
    end
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
