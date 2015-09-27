require 'rails_helper'

RSpec.describe RewardsCardsController, type: :controller do
  let(:user) { create(:user) }
  let(:retailer) { create(:retailer) }
  let(:insurance_policy) { create(:insurance, user_id: user.id) }
  let(:valid_attributes) {
    {
      rewards_number: Faker::Business.credit_card_number,
      retailer_id:    retailer.id,
      user_id:        user.id
    }
  }

  let(:invalid_attributes) {
    {
      rewards_number: nil,
      retailer_id:    retailer.id,
      user_id:        user.id
    }
  }

  let(:valid_session) { {} }

  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["HTTP_REFERER"] = 'http://test.host/'
    allow(controller).to receive(:current_user) { user }
    sign_in user
  end

  describe "GET #index" do
    it "assigns all rewards_cards as @rewards_cards" do
      rewards_card = RewardsCard.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:rewards_cards)).to eq([rewards_card])
    end
  end

  describe "GET #show" do
    it "assigns the requested rewards_card as @rewards_card" do
      rewards_card = RewardsCard.create! valid_attributes
      get :show, {:id => rewards_card.to_param}, valid_session
      expect(assigns(:rewards_card)).to eq(rewards_card)
    end
  end

  describe "GET #new" do
    it "assigns a new rewards_card as @rewards_card" do
      get :new, {}, valid_session
      expect(assigns(:rewards_card)).to be_a_new(RewardsCard)
    end
  end

  describe "GET #edit" do
    it "assigns the requested rewards_card as @rewards_card" do
      rewards_card = RewardsCard.create! valid_attributes
      get :edit, {:id => rewards_card.to_param}, valid_session
      expect(assigns(:rewards_card)).to eq(rewards_card)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new RewardsCard" do
        expect {
          post :create, {:rewards_card => valid_attributes}, valid_session
        }.to change(RewardsCard, :count).by(1)
      end

      it "assigns a newly created rewards_card as @rewards_card" do
        post :create, {:rewards_card => valid_attributes}, valid_session
        expect(assigns(:rewards_card)).to be_a(RewardsCard)
        expect(assigns(:rewards_card)).to be_persisted
      end

      it "redirects to the created rewards_card" do
        post :create, {:rewards_card => valid_attributes}, valid_session
        expect(response).to redirect_to(RewardsCard.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved rewards_card as @rewards_card" do
        post :create, {:rewards_card => invalid_attributes}, valid_session
        expect(assigns(:rewards_card)).to be_a_new(RewardsCard)
      end

      it "re-renders the 'new' template" do
        post :create, {:rewards_card => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:user_2) { create(:user) }
      let(:retailer_2) { create(:retailer) }
      let(:new_attributes) {
        {
          rewards_number: Faker::Business.credit_card_number,
          retailer_id:    retailer_2.id,
          user_id:        user_2.id
        }
      }

      it "updates the requested rewards_card" do
        rewards_card = RewardsCard.create! valid_attributes
        put :update, {:id => rewards_card.to_param, :rewards_card => new_attributes}, valid_session
        rewards_card.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested rewards_card as @rewards_card" do
        rewards_card = RewardsCard.create! valid_attributes
        put :update, {:id => rewards_card.to_param, :rewards_card => valid_attributes}, valid_session
        expect(assigns(:rewards_card)).to eq(rewards_card)
      end

      it "redirects to the rewards_card" do
        rewards_card = RewardsCard.create! valid_attributes
        put :update, {:id => rewards_card.to_param, :rewards_card => valid_attributes}, valid_session
        expect(response).to redirect_to(rewards_card)
      end
    end

    context "with invalid params" do
      it "assigns the rewards_card as @rewards_card" do
        rewards_card = RewardsCard.create! valid_attributes
        put :update, {:id => rewards_card.to_param, :rewards_card => invalid_attributes}, valid_session
        expect(assigns(:rewards_card)).to eq(rewards_card)
      end

      it "re-renders the 'edit' template" do
        rewards_card = RewardsCard.create! valid_attributes
        put :update, {:id => rewards_card.to_param, :rewards_card => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested rewards_card" do
      rewards_card = RewardsCard.create! valid_attributes
      expect {
        delete :destroy, {:id => rewards_card.to_param}, valid_session
      }.to change(RewardsCard, :count).by(-1)
    end

    it "redirects to the rewards_cards list" do
      rewards_card = RewardsCard.create! valid_attributes
      delete :destroy, {:id => rewards_card.to_param}, valid_session
      expect(response).to redirect_to(rewards_cards_url)
    end
  end

end
