require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "GET #index" do
    it "assigns users" do
      travel_to Time.zone.local(2017, 9, 25) do
        users = FactoryBot.create_list(:user, 2)
        get :index
        expect(assigns(:users)).to eq users
      end
    end

    it "assigns records grouped by user_id" do
      travel_to Time.zone.local(2017, 9, 25) do
        users = FactoryBot.create_list(:user, 2)
        records = users.map do |user|
          [
            FactoryBot.create(:record, user: user, started_at: Time.zone.local(2017, 9, 25, 7, 57, 28)),
            FactoryBot.create(:record, user: user, started_at: Time.zone.local(2017, 9, 25, 8, 57, 28))
          ]
        end
        get :index
        expect(assigns(:users)).to eq users
        expect(assigns(:records)[users[0].id]).to eq records[0]
        expect(assigns(:records)[users[1].id]).to eq records[1]
      end
    end
  end
end
