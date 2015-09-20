class DashboardController < ApplicationController
  # before_action :set_user, only: [:index]
  before_action :load_and_authorize_current_user, only: [:index]
  layout 'dashboard'

  def index
    # if Rails.env.production? || Rails.env.development?
    #   @browser = Browser.new(ua: request.user_agent)
    # end
    if @user
      # if request.path != dashboard_path(@dashboard)
      #   redirect_to @dashboard, status: :moved_permanently
      # end

    else
      render file: 'public/404', status: 404, formats: [:html]
    end
  end

  private
    def load_and_authorize_current_user
      authorize!(params[:action].to_sym, @user)
      @user = User.find(current_user) || current_user
    end

    def set_user
      @user = User.find(current_user)
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation,
        :first_name, :last_name, :preferred_name, :remember_me)
    end

end
