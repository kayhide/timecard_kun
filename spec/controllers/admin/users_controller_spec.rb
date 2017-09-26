require 'rails_helper'

RSpec.describe Admin::UsersController, type: :controller do

  let(:invalid_attributes) {
    {
      name: ''
    }
  }

  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      user = FactoryGirl.create(:user)
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      user = FactoryGirl.create(:user)
      get :show, params: {id: user.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      user = FactoryGirl.create(:user)
      get :edit, params: {id: user.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    let(:valid_attributes) {
      {
        name: 'Yamada Taro'
      }
    }

    context "with valid params" do
      it "creates a new User" do
        expect {
          post :create, params: {user: valid_attributes}, session: valid_session
        }.to change(User, :count).by(1)
      end

      it "redirects to the created user" do
        post :create, params: {user: valid_attributes}, session: valid_session
        expect(response).to redirect_to([:admin, :users])
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {user: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        {
          name: 'Suzuki Ichiro'
        }
      }

      it "updates the requested user" do
        user = FactoryGirl.create(:user)
        put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
        user.reload
        expect(user.name).to eq 'Suzuki Ichiro'
      end

      it "redirects to the users list" do
        user = FactoryGirl.create(:user)
        put :update, params: {id: user.to_param, user: new_attributes}, session: valid_session
        expect(response).to redirect_to([:admin, :users])
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        user = FactoryGirl.create(:user)
        put :update, params: {id: user.to_param, user: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested user" do
      user = FactoryGirl.create(:user)
      expect {
        delete :destroy, params: {id: user.to_param}, session: valid_session
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = FactoryGirl.create(:user)
      delete :destroy, params: {id: user.to_param}, session: valid_session
      expect(response).to redirect_to([:admin, :users])
    end
  end

end
