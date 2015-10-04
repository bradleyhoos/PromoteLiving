class UsersController < ApplicationController
  # before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # layout 'dashboard'

  def show
    # if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
    # end
  end

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

  # def set_user
  #   @user = User.find(params[:user])
  # end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name, :preferred_name, :remember_me, :id)
  end
end
