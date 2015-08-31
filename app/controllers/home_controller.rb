class HomeController < ApplicationController
  before_filter :authenticate_user!
  layout 'application'

  def index
    #render text: "Matt did something in the controller of home"
  end

end
