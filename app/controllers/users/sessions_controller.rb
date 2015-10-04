# class Devise::SessionsController < DeviseController
class Users::SessionsController < Devise::SessionsController
  prepend_before_filter :require_no_authentication, only: [ :new, :create ]
  # prepend_before_filter :check_for_complete_account, only: [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, only: :create
  prepend_before_filter :verify_signed_out_user, only: :destroy
  prepend_before_filter only: [ :create, :destroy ] { request.env["devise.skip_timeout"] = true }
  after_action :set_csrf_headers, only: :create

  # GET /resource/sign_in
  def new
    check_for_complete_account
    self.resource = resource_class.new(sign_in_params)
    clean_up_passwords(resource)
    respond_with(resource, serialize_options(resource))
  end

  # POST /resource/sign_in
  def create
    if !current_user.account_is_complete?
      check_for_complete_account
    else
      response.headers['X-CSRF-Token'] = form_authenticity_token
      self.resource = warden.authenticate!(auth_options)
      set_flash_message(:notice, :signed_in) if is_flashing_format?
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message :notice, :signed_out if signed_out && is_flashing_format?
    yield if block_given?
    respond_to_on_destroy
  end

  protected
    def set_csrf_headers
      if request.xhr?
        # Add the newly created csrf token to the page headers
        # These values are sent on 1 request only
        response.headers['X-CSRF-Token'] = "#{form_authenticity_token}"
        response.headers['X-CSRF-Param'] = "#{request_forgery_protection_token}"
      end
    end

    def sign_in_params
      devise_parameter_sanitizer.sanitize(:sign_in)
    end

    def serialize_options(resource)
      methods = resource_class.authentication_keys.dup
      methods = methods.keys if methods.is_a?(Hash)
      methods << :password if resource.respond_to?(:password)
      { methods: methods, only: [:password] }
    end

    def auth_options
      { scope: resource_name, recall: "#{controller_path}#new" }
    end

  private

    # def check_for_complete_account
    #   if user_signed_in?
    #     if current_user.is_insured?
    #       check_for_rewards_cards
    #     else
    #       redirect_to new_insurance_path, notice: 'Please add your insurance information.' and return
    #     end

    #     if current_user.has_hsa?
    #       redirect_to dashboard_path, notice: "Congratulations! You're ready to earn rewards for healthy purchases!" and return
    #     else
    #       redirect_to new_health_savings_account_path, notice: 'Please add your insurance information.' and return
    #     end
    #   end
    # end

    # def check_for_rewards_cards
    #   if user.has_rewards_cards?
    #     redirect_to dashboard_path, notice: "Congratulations! You're ready to earn rewards for healthy purchases!" and return
    #   else
    #     redirect_to new_rewards_card_path, notice: 'Please add a rewards card.' and return
    #   end
    # end

    # Check if there is no signed in user before doing the sign out.
    # If there is no signed in user, it will set the flash message and redirect
    # to the after_sign_out path.
    def verify_signed_out_user
      if all_signed_out?
        set_flash_message :notice, :already_signed_out if is_flashing_format?
        respond_to_on_destroy
      end
    end

    def all_signed_out?
      users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }
      users.all?(&:blank?)
    end

    def respond_to_on_destroy
      # We actually need to hardcode this as Rails default responder doesn't
      # support returning empty response on GET request
      respond_to do |format|
        format.all { head :no_content }
        format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
      end
    end

end
