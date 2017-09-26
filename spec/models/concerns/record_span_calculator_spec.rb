require 'rails_helper'

RSpec.shared_examples RecordSpanCalculator do
  let(:record) { FactoryGirl.build(:record) }
  let(:today) { Date.new(2017, 9, 25) }

  before do
    Timecop.freeze today
  end

  after do
    Timecop.return
  end

  describe '#ensure_regular_span' do
    it 'sets span' do
      record.started_at = Time.zone.parse('09:00')
      record.finished_at = Time.zone.parse('10:23')
      record.save
      expect(record.regular_span).to eq 1 * 3600 + 23 * 60
    end

    it 'assumes 8:00 if started_at is absent' do
      record.started_at = nil
      record.finished_at = Time.zone.parse('10:23')
      record.save
      expect(record.regular_span).to eq 2 * 3600 + 23 * 60
    end

    it 'cuts 1 hour as a break time when more than 6 hours' do
      record.started_at = Time.zone.parse('08:00')
      record.finished_at = Time.zone.parse('14:23')
      record.save
      expect(record.regular_span).to eq 5 * 3600 + 23 * 60
    end

    it 'sets nil if finished_at is abasent' do
      record.started_at = Time.zone.parse('09:00')
      record.finished_at = Time.zone.parse('10:23')
      record.save
      record.finished_at = nil
      record.save
      expect(record.regular_span).to eq nil
    end
  end

  describe '#ensure_early_span' do
    it 'sets span' do
      record.started_at = Time.zone.parse('04:00')
      record.finished_at = Time.zone.parse('05:23')
      record.save
      expect(record.early_span).to eq 1 * 3600 + 23 * 60
    end

    it 'assumes 8:00 if started_at is absent' do
      record.started_at = nil
      record.finished_at = Time.zone.parse('10:23')
      record.save
      expect(record.early_span).to eq 0
    end

    it 'drops after 8:00' do
      record.started_at = Time.zone.parse('06:00')
      record.finished_at = Time.zone.parse('10:23')
      record.save
      expect(record.early_span).to eq 2 * 3600
    end

    it 'sets nil if finished_at is abasent' do
      record.started_at = Time.zone.parse('09:00')
      record.finished_at = Time.zone.parse('10:23')
      record.save
      record.finished_at = nil
      record.save
      expect(record.early_span).to eq nil
    end
  end
end

RSpec.describe Record, type: :model do
  it_behaves_like RecordSpanCalculator
end