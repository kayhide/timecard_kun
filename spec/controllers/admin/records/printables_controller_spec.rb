require 'rails_helper'

RSpec.describe Admin::Records::PrintablesController, type: :controller do
  let(:today) { Time.zone.parse('2017-10-03 19:19:41') }

  describe "GET #index" do
    before do
      Timecop.freeze today
    end

    after do
      Timecop.return
    end

    it "assigns records of given cour grouped by user" do
      users = FactoryBot.create_list(:user, 2)
      records = []
      users[0].tap do |user|
        FactoryBot.create(:record, user: user, started_at: '2016-03-20 23:59:59')
        records << [
          FactoryBot.create(:record, user: user, started_at: '2016-03-21 00:00:00'),
          FactoryBot.create(:record, user: user, started_at: '2016-04-20 23:59:59')
        ]
        FactoryBot.create(:record, user: user, started_at: '2016-04-21 00:00:00')
      end
      users[1].tap do |user|
        FactoryBot.create(:record, user: user, started_at: '2016-03-20 23:59:59')
        records << [
          FactoryBot.create(:record, user: user, started_at: '2016-03-21 08:05:20'),
        ]
        FactoryBot.create(:record, user: user, started_at: '2016-04-21 00:00:00')
      end
      get :index, params: { year: '2016', month: '3' }
      expect(assigns(:records))
        .to eq({
                 users[0].id => records[0],
                 users[1].id => records[1]
               })
    end

    it "assigns sums of regular_span from beginning of year to end of cour" do
      users = FactoryBot.create_list(:user, 2)
      users[0].tap do |user|
        FactoryBot.create(:record, user: user, started_at: nil, finished_at: '2016-01-01 17:00:00')
        FactoryBot.create(:record, user: user, started_at: nil, finished_at: '2016-04-20 17:00:00')
      end
      users[1].tap do |user|
        FactoryBot.create(:record, user: user, started_at: nil, finished_at: '2016-04-20 23:59:59')
      end
      get :index, params: { year: '2016', month: '3' }
      expect(assigns(:boy_to_eoc_regular_span_sums))
        .to eq({
                 users[0].id => 16.hours,
                 users[1].id => 14.hours + 59.minutes + 59.seconds
               })
    end

    it "assigns sums of regular_span without time range" do
      user = FactoryBot.create(:user)
      FactoryBot.create(:record, user: user, started_at: nil, finished_at: '2015-12-31 17:00:00')
      FactoryBot.create(:record, user: user, started_at: nil, finished_at: '2016-04-21 17:00:00')
      get :index, params: { year: '2016', month: '3' }
      expect(assigns(:boy_to_eoc_regular_span_sums)).to eq({})
    end
  end
end
