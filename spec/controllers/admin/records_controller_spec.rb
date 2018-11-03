require 'rails_helper'

RSpec.describe Admin::RecordsController, type: :controller do

  let(:invalid_attributes) {
    {
      user_id: nil
    }
  }

  describe "GET #index" do
    let(:today) { Time.zone.parse('2017-11-04 16:49:12') }

    before do
      Timecop.freeze today
    end

    after do
      Timecop.return
    end

    it "assigns records" do
      records = FactoryBot.create_list(:record, 2, started_at: Time.current)
      get :index, params: {}
      expect(assigns(:records)).to eq records
    end

    it 'filters if :user_id is given' do
      user = FactoryBot.create(:user)
      records = FactoryBot.create_list(:record, 2, user: user, started_at: Time.current)
      FactoryBot.create(:record, started_at: Time.current)
      get :index, params: { user_id: user.id }
      expect(assigns(:records)).to eq records
    end
  end

  describe "POST #create.js" do
    let(:user) { FactoryBot.create(:user) }
    let(:valid_attributes) {
      {
        user_id: user.id
      }
    }

    context "with valid params" do
      it "creates a new Record" do
        expect {
          post :create, params: {record: valid_attributes}, format: :js
        }.to change(Record, :count).by(1)
      end

      it 'creates with :user_id param only' do
        expect {
          post :create, params: {user_id: user.id}, format: :js
        }.to change(Record, :count).by(1)
        record = Record.last
        expect(record.user).to eq user
      end

      it 'creates with :user_id and other params' do
        attrs = { started_at: Time.zone.parse('2017-11-04 16:49:12') }
        expect {
          post :create, params: {user_id: user.id, record: attrs}, format: :js
        }.to change(Record, :count).by(1)
        record = Record.last
        expect(record.user).to eq user
        expect(record.started_at).to eq Time.zone.parse('2017-11-04 16:49:12')
      end
    end

    context "with invalid params" do
      it "responses with unprocessable entity" do
        post :create, params: {record: invalid_attributes}, format: :js
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH #update.js" do
    let!(:record) { FactoryBot.create(:record) }

    context "with valid params" do
      let(:new_attributes) {
        {
          started_at: Time.zone.parse('2017-10-03 9:57:11'),
          finished_at: Time.zone.parse('2017-10-03 17:19:41')
        }
      }

      it "updates the requested record" do
        patch :update, params: {id: record.id, record: new_attributes}, format: :js
        record.reload
        expect(record.started_at).to eq Time.zone.parse('2017-10-03 9:57:11')
        expect(record.finished_at).to eq Time.zone.parse('2017-10-03 17:19:41')
      end
    end

    context "with invalid params" do
      it "responses with unprocessable entity" do
        patch :update, params: {id: record.id, record: invalid_attributes}, format: :js
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:record) { FactoryBot.create(:record) }

    it "destroys the requested record" do
      expect {
        delete :destroy, params: {id: record.id}, format: :js
      }.to change(Record, :count).by(-1)
    end
  end
end
