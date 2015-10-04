require 'rails_helper'

RSpec.describe HealthSavingsAccountsController, type: :controller do
  let(:user) { create(:user) }
  let(:insurance_policy) { create(:insurance, user_id: user.id) }
  let(:valid_attributes) {
    {
      account_number: Faker::Business.credit_card_number,
      routing_number: Faker::Business.credit_card_number,
      account_name:   Faker::Name.name,
      user_id:        user.id
    }
  }

  let(:invalid_attributes) {
    {
      account_number: '01',
      routing_number: '10A7999-000-1ANS8999',
      account_name:   '',
      user_id:        nil
    }
  }

  let(:valid_session) { {} }

  def setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["HTTP_REFERER"] = 'http://test.host/'
    allow(controller).to receive(:current_user) { user }
  end

  before(:each) do
    # setup
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @request.env["HTTP_REFERER"] = 'http://test.host/'
    allow(controller).to receive(:current_user) { user }
    sign_in user
  end

  describe "GET #index" do
    it "assigns all health_savings_accounts as @health_savings_accounts" do
      health_savings_account = HealthSavingsAccount.create! valid_attributes
      get :index, {}, valid_session
      expect(assigns(:health_savings_accounts)).to eq(health_savings_account)
    end
  end

  describe "GET #show" do
    it "assigns the requested health_savings_account as @health_savings_account" do
      health_savings_account = HealthSavingsAccount.create! valid_attributes
      get :show, {:id => health_savings_account.to_param}, valid_session
      expect(assigns(:health_savings_account)).to eq(health_savings_account)
    end
  end

  describe "GET #new" do
    it "assigns a new health_savings_account as @health_savings_account" do
      get :new, {}, valid_session
      expect(assigns(:health_savings_account)).to be_a_new(HealthSavingsAccount)
    end
  end

  describe "GET #edit" do
    it "assigns the requested health_savings_account as @health_savings_account" do
      health_savings_account = HealthSavingsAccount.create! valid_attributes
      get :edit, {:id => health_savings_account.to_param}, valid_session
      expect(assigns(:health_savings_account)).to eq(health_savings_account)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new HealthSavingsAccount" do
        expect {
          post :create, {:health_savings_account => valid_attributes}, valid_session
        }.to change(HealthSavingsAccount, :count).by(1)
      end

      it "assigns a newly created health_savings_account as @health_savings_account" do
        post :create, {:health_savings_account => valid_attributes}, valid_session
        expect(assigns(:health_savings_account)).to be_a(HealthSavingsAccount)
        expect(assigns(:health_savings_account)).to be_persisted
      end

      it "redirects to the created health_savings_account" do
        post :create, {:health_savings_account => valid_attributes}, valid_session
        if user.is_insured?
          expect(response).to redirect_to(HealthSavingsAccount.last)
        else
          expect(response).to redirect_to(new_insurance_path)
        end
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved health_savings_account as @health_savings_account" do
        post :create, {:health_savings_account => invalid_attributes}, valid_session
        expect(assigns(:health_savings_account)).to be_a_new(HealthSavingsAccount)
      end

      it "re-renders the 'new' template" do
        post :create, {:health_savings_account => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested health_savings_account" do
        health_savings_account = HealthSavingsAccount.create! valid_attributes
        put :update, {:id => health_savings_account.to_param, :health_savings_account => new_attributes}, valid_session
        health_savings_account.reload
        skip("Add assertions for updated state")
      end

      it "assigns the requested health_savings_account as @health_savings_account" do
        health_savings_account = HealthSavingsAccount.create! valid_attributes
        put :update, {:id => health_savings_account.to_param, :health_savings_account => valid_attributes}, valid_session
        expect(assigns(:health_savings_account)).to eq(health_savings_account)
      end

      it "redirects to the health_savings_account" do
        health_savings_account = HealthSavingsAccount.create! valid_attributes
        put :update, {:id => health_savings_account.to_param, :health_savings_account => valid_attributes}, valid_session
        expect(response).to redirect_to(health_savings_account)
      end
    end

    context "with invalid params" do
      it "assigns the health_savings_account as @health_savings_account" do
        health_savings_account = HealthSavingsAccount.create! valid_attributes
        put :update, {:id => health_savings_account.to_param, :health_savings_account => invalid_attributes}, valid_session
        expect(assigns(:health_savings_account)).to eq(health_savings_account)
      end

      it "re-renders the 'edit' template" do
        health_savings_account = HealthSavingsAccount.create! valid_attributes
        put :update, {:id => health_savings_account.to_param, :health_savings_account => invalid_attributes}, valid_session
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested health_savings_account" do
      health_savings_account = HealthSavingsAccount.create! valid_attributes
      expect {
        delete :destroy, {:id => health_savings_account.to_param}, valid_session
      }.to change(HealthSavingsAccount, :count).by(-1)
    end

    it "redirects to the health_savings_accounts list" do
      health_savings_account = HealthSavingsAccount.create! valid_attributes
      delete :destroy, {:id => health_savings_account.to_param}, valid_session
      expect(response).to redirect_to(health_savings_accounts_url)
    end
  end

end
