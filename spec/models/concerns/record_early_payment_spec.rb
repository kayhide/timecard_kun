require 'rails_helper'

RSpec.shared_examples RecordEarlyPayment do
  let(:record) { FactoryBot.build(:record) }
  let(:today) { Date.new(2017, 9, 25) }

  around do |e|
    travel_to today do
      e.run
    end
  end

  describe '#early_payment' do
    it 'calls .early_span with #early_span' do
      record.started_at = Time.zone.parse('04:00')
      record.finished_at = Time.zone.parse('05:23')
      record.save
      expect(Record).to receive(:early_payment).with(record.early_span)
      record.early_payment
    end
  end

  describe '.early_payment' do
    it 'returns span hours * 70' do
      span = 1.hours + 30.minutes
      expect(Record.early_payment span).to eq 150
    end

    it 'returns span hours * 70' do
      span = 59.seconds
      expect(Record.early_payment span).to eq 1
    end
  end
end

RSpec.describe Record, type: :model do
  it_behaves_like RecordEarlyPayment
end
