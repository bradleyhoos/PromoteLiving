class HomeController < ApplicationController
  layout 'application'

  def index
    authenticate_user! if current_user.present? && signed_in?
  end

end
