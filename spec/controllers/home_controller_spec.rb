require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    after do
      Timecop.return
    end

    it "returns http success" do
      Timecop.freeze Time.zone.local(2017, 9, 25)
      users = FactoryGirl.create_list(:user, 2)
      records = users.map do |user|
        FactoryGirl.create(:record, user: user, started_at: Time.zone.local(2017, 9, 25, 7, 57, 28))
      end
      get :index
      expect(assigns(:users)).to eq users
    end
  end
end
