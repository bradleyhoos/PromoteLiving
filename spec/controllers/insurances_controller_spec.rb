require 'rails_helper'

RSpec.describe InsurancesController, type: :controller do
  let(:user) { create(:user) }

  def setup
    allow(controller).to receive(:current_user) { user }
  end

  before(:each) do
    setup
    sign_in user
  end

  context "signed in" do
    describe "GET 'index'" do
      it 'assigns the requested user as @user' do
        get :index
        expect(assigns(:user)).to eq(user)
      end
    end
  end

  context "signed out" do
    describe "GET 'index'" do
      it 'should redirect_to root_path' do
        get :index
        # binding.pry
        expect(response).to be_success#redirect_to(root_path)
      end
    end
  end

end
