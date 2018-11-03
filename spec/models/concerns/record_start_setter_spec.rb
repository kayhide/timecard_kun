require 'rails_helper'

RSpec.shared_examples RecordStartSetter do
  let(:today) { Date.new(2017, 9, 25) }

  describe '#ensure_started_at' do
    around do |e|
      travel_to today do
        e.run
      end
    end

    it 'set 8:00 if started_at is absent' do
      record.started_at = nil
      record.finished_at = Time.zone.parse('10:23')
      expect {
        record.save
      }.to change { record.started_at }.from(nil).to(Time.zone.parse('08:00'))
    end

    it 'do nothing if started_at is present' do
      record.started_at = Time.zone.parse('09:00')
      record.finished_at = Time.zone.parse('10:23')
      expect {
        record.save
      }.not_to change { record.started_at }
    end

    it 'do nothing if started_at and finished_at are both absent' do
      record.started_at = nil
      record.finished_at = nil
      expect {
        record.save
      }.not_to change { record.started_at }
    end

    it 'sets date if started_on is given' do
      record.started_on = '2017-10-03'
      record.started_at = '09:00'
      record.finished_at = '10:23'
      record.save
      expect(record.started_at).to eq Time.zone.parse('2017-10-03 09:00:00')
      expect(record.finished_at).to eq Time.zone.parse('2017-10-03 10:23:00')
    end

    it 'sets finished_at so that not to be earlier than started_at' do
      record.started_on = '2017-10-03'
      record.started_at = '09:00'
      record.finished_at = '02:23'
      record.save
      expect(record.started_at).to eq Time.zone.parse('2017-10-03 09:00:00')
      expect(record.finished_at).to eq Time.zone.parse('2017-10-04 02:23:00')
    end
  end
end

RSpec.describe Record, type: :model do
  let(:record) { FactoryBot.create(:record) }
  it_behaves_like RecordStartSetter
end
