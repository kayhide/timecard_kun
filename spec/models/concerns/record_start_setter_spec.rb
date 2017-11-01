require 'rails_helper'

RSpec.shared_examples RecordStartSetter do
  let(:date) { Date.new(2017, 9, 25) }


  describe '#ensure_started_at' do
    it 'set 8:00 and is_start_implicit if started_at is absent' do
      record.started_at = nil
      record.finished_at = Time.zone.parse('10:23')
      expect {
        record.save
      }.to change { record.started_at }.from(nil).to(Time.zone.parse('08:00'))
      expect(record.is_start_implicit).to eq true
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
  end
end

RSpec.describe Record, type: :model do
  let(:record) { FactoryGirl.create(:record) }
  it_behaves_like RecordStartSetter
end
