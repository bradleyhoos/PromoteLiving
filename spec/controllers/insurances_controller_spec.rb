require 'rails_helper'

RSpec.describe InsurancesController, type: :controller do
  let(:user) { create(:user) }

  def setup
    allow(controller).to receive(:current_user) { user }
  end

  context "signed in" do
    before(:each) do
      setup
      sign_in user
    end

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
        expect(response).to be_redirect
      end
    end
  end

end
