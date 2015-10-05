class UsersController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :authenticate_user!
  layout 'application'

  def edit
    render nothing: true
  end

  def update_password
    @user = User.find(current_user.id)
    @user.update_attributes(user_params)
    if @user.save
      sign_in @user, bypass: true
      redirect_to settings_path, notice: "Account settings updated"
    else
      redirect_to settings_path
      flash[:errors] = "Nothing Updated"
    end
  end

  private
    def get_user
      if @user.nil?
        @user = current_user.nil? ? set_user : User.find(params[:user])
      end
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :preferred_name, :remember_me, :id)
    end
end
