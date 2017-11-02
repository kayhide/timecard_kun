require 'rails_helper'

RSpec.shared_examples RecordDatelessHandler do
  let(:original_date) { Date.new(2017, 9, 25) }
  let(:today) { Date.new(2017, 10, 3) }

  describe '#handle_dateless' do
    before do
      Timecop.freeze today
    end

    after do
      Timecop.return
    end

    it 'sets started_at and finished_at with original started_at date' do
      record.dateless_started_at = '9:24'
      record.dateless_finished_at = '17:23'
      expect(record.dateless_started_at).to eq Time.zone.parse('2000-01-01 09:24:00')
      expect(record.dateless_finished_at).to eq Time.zone.parse('2000-01-01 17:23:00')
      record.save
      expect(record.started_at).to eq Time.zone.parse('2017-09-25 09:24:00')
      expect(record.finished_at).to eq Time.zone.parse('2017-09-25 17:23:00')
    end

    it 'sets finished_at so that not to be earlier than started_at' do
      record.dateless_started_at = '9:24'
      record.dateless_finished_at = '02:23'
      record.save
      expect(record.started_at).to eq Time.zone.parse('2017-09-25 09:24:00')
      expect(record.finished_at).to eq Time.zone.parse('2017-09-26 02:23:00')
    end

    it 'sets finished_at of nil when blank is given' do
      record.dateless_finished_at = ''
      record.save
      expect(record.finished_at).to eq nil
    end
  end
end

RSpec.describe Record, type: :model do
  let(:record) { FactoryGirl.create(:record, started_at: '2017-09-25 08:03:26') }
  it_behaves_like RecordDatelessHandler
end
