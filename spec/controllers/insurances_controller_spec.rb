require 'rails_helper'

RSpec.describe InsurancesController, type: :controller do
  let(:user) { create(:user) }
  let(:insurance_policy) { create(:insurance, user_id: user.id) }
  let(:valid_attributes) {
   {first_name: 'John', last_name: 'Doe', enrollee_id: SecureRandom.hex(8),
    group_number: SecureRandom.hex(8), user_id: user.id}
  }

  def setup
    allow(controller).to receive(:current_user) { user }
  end

  context "signed in" do
    before(:each) do
      setup
      sign_in user
      request.env["HTTP_REFERER"] = 'http://test.host/'
    end

    describe "GET 'index'" do
      it 'assigns the requested user as @user' do
        get :index
        expect(assigns(:user)).to eq(user)
      end
    end

    describe "GET new" do
      it "assigns a new insurance as @insurance_policy" do
        get :new, id: @insurance_policy.id
        expect(assigns(:insurance)).to be_a_new(Insurance)
      end
    end

    describe "GET edit" do
      it "assigns the requested insurance as @insurance_policy" do
        get :edit, {id: @insurance_policy.to_param}
        expect(assigns(:insurance)).to eq(@insurance_policy)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new insurance" do
          expect {
            post :create, {insurance: valid_attributes}
          }.to change(Insurance, :count).by(1)
        end

        it "assigns a newly created insurance as @insurance_policy" do
          post :create, {insurance: valid_attributes}
          expect(assigns(:insurance)).to be_a(Insurance)
          expect(assigns(:insurance)).to be_persisted
        end

        it "redirects back" do
          post :create, {insurance: valid_attributes}
          expect(response).to redirect_to(:back)
        end
      end

      describe "with invalid params" do
        it "requires insurance parameter" do
          # Trigger the behavior that occurs when invalid params are submitted
          expect {
            post :create, {insurance: { }}
          }.to raise_error(ActionController::ParameterMissing)
        end

        it "assigns a newly created but unsaved insurance as @insurance_policy" do
          # Trigger the behavior that occurs when invalid params are submitted
          expect_any_instance_of(Insurance).to receive(:save).and_return(false)
          post :create, {insurance: { note: '' }}
          expect(assigns(:insurance)).to be_a_new(Insurance)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          expect_any_instance_of(Insurance).to receive(:save).and_return(false)
          post :create, {insurance: { note: '' }}
          expect(response).to render_template("new")
        end
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
