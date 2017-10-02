require 'rails_helper'

RSpec.describe Admin::Users::HiddenController, type: :controller do
  describe 'POST #create' do
    it 'sets hidden true' do
      user = FactoryGirl.create(:user)
      expect {
        put :create, params: {id: user.to_param}, format: :js
      }.to change{ user.reload.hidden? }.from(false).to(true)
    end
  end

  describe 'DELETE #destroy' do
    it 'sets hidden false' do
      user = FactoryGirl.create(:user, hidden: true)
      expect {
        delete :destroy, params: {id: user.to_param}, format: :js
      }.to change{ user.reload.hidden? }.from(true).to(false)
    end
  end
end
