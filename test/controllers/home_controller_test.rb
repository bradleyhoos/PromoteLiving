require 'test_helper'

class HomeControllerTest < ActionController::TestCase
     include Devise::TestHelpers  
   def setup
      @user = User.create!(
        :email => 'testuser@demomailtest.com',
        :password => 'MyTestingPassword',
        :password_confirmation => 'MyTestingPassword'
      )
	  @user.confirm!
      sign_in @user
   end

   test "should get index" do
      get :index    
      assert_response :success
      
   end

end
