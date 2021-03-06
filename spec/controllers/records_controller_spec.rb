require 'rails_helper'

RSpec.describe RecordsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }

  describe 'POST #start' do
    it 'creates new record' do
      expect {
        post :start, params: { user_id: user.id }, format: :js
      }.to change(Record, :count).by(1)
    end
  end

  describe 'POST #finish' do
    let(:started_at) { Time.zone.parse('2017-09-25 07:58:49') }
    let(:finished_at) { Time.zone.parse('2017-09-25 18:01:23') }

    around do |e|
      travel_to finished_at do
        e.run
      end
    end

    it 'finishes existing record' do
      record = user.records.create(started_at: started_at)
      expect {
        post :finish, params: { user_id: user.id }, format: :js
      }.to change { record.reload.finished_at }.to(finished_at)
    end

    it 'creates new record if unfinished record is absent within 24 hours' do
      user.records.create(started_at: finished_at - 24.hours - 1.second)
      expect {
        post :finish, params: { user_id: user.id }, format: :js
      }.to change(Record, :count).by(1)
      expect(user.records.last.started_at).to eq Time.zone.parse('2017-09-25 08:00')
      expect(user.records.last.finished_at).to eq finished_at
    end
  end
end
