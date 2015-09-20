class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_filter :verify_authenticity_token, only: :create
  prepend_before_filter :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]
  # layout 'dashboard', only: [:edit]

   def create
     build_resource(sign_up_params)
    if resource.save
      yield resource if block_given?
        # UserMailer.confirm(resource).deliver unless Rails.env.test?
        sign_in resource
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  def new
    build_resource({})
    @plan = params[:plan]
    if @plan
      super
    end
    # respond_with self.resource
  end

  def edit
    # TODO: Not Oauth Implemented
    # @connected_twitter = current_user.connected_with?("twitter")
    # @connected_facebook = current_user.connected_with?("facebook")
  end

   def update
    # Get all params for :account_update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    # Set current_user
    @user = User.find(current_user.id)
    # Allow user to update without using password.
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
      account_update_params.delete("current_password")
      update_resource_without_password(@user, account_update_params)
    else
      update_resource_with_password(@user, account_update_params)
    end
    if resource.persisted?
      #@user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      sign_in @user, bypass: true
      redirect_to :back
    else
      render "edit"
    end
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # Forces the session data which is usually expired after sign in to be expired now.
  # This is useful if the user wants to cancel oauth signing in/up in the middle of the process, removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  def build_resource(*args)
    super
    if params[:plan]
      resource.add_role(params[:plan])
    end
  end

  protected

  def update_resource_without_password(resource, params)
    resource.update_without_password(params)
  end

  def update_resource_with_password(resource, params)
    resource.update_with_password(params)
  end

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) && resource.pending_reconfirmation? && previous != resource.unconfirmed_email
  end

  # By default we want to require a password checks on update. You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    # resource.company ? dashboard_path : new_company_path
    after_sign_in_path_for(resource)
  end

  # The path used after sign up for inactive accounts. You need to overwrite this method!
  def after_inactive_sign_up_path_for(resource)
    respond_to?(:root_path) ? root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite this method!
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation,
     :first_name, :last_name, :preferred_name, :current_password)
    # devise_parameter_sanitizer.sanitize(:account_update)
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
     :first_name, :last_name, :preferred_name)
  end

  # https://github.com/plataformatec/devise/wiki/How-To%3a-Allow-users-to-edit-their-account-without-providing-a-password
  private

  def needs_password?(user, params)
    (params[:user].has_key?(:email) && user.email != params[:user][:email]) ||
     !params[:user][:password].present? #||
     # !params[:user][:password_confirmation].present?
  end

  # def needs_password?(user, params)
  #   user.email != params[:user][:email] ||
  #     params[:user][:password].present? ||
  #     params[:user][:password_confirmation].present?
  # end

  def resource_params
    params.require(:user).permit(:email, :password, :password_confirmation,
     :first_name, :last_name, :preferred_name)
  end
end
