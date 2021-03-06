require 'rails_helper'

RSpec.shared_examples RecordSpanCalculator do
  let(:record) { FactoryBot.build(:record) }
  let(:today) { Date.new(2017, 9, 25) }

  around do |e|
    travel_to today do
      e.run
    end
  end

  describe '#ensure_regular_span' do
    it 'sets span' do
      record.started_at = Time.zone.parse('09:00')
      record.finished_at = Time.zone.parse('10:23')
      record.save
      expect(record.regular_span).to eq 1.hours + 23.minutes
    end

    it 'assumes 8:00 if started_at is absent' do
      record.started_at = nil
      record.finished_at = Time.zone.parse('10:23')
      record.save
      expect(record.regular_span).to eq 2.hours + 23.minutes
    end

    it 'cuts 1 hour as a break time when more than 6 hours' do
      record.started_at = Time.zone.parse('08:00')
      record.finished_at = Time.zone.parse('14:23')
      record.save
      expect(record.regular_span).to eq 5.hours + 23.minutes
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
      record.started_at = Time.zone.parse('05:00')
      record.finished_at = Time.zone.parse('06:23')
      record.save
      expect(record.early_span).to eq 1.hours + 23.minutes
    end

    it 'drops after 8:00' do
      record.started_at = Time.zone.parse('06:00')
      record.finished_at = Time.zone.parse('10:23')
      record.save
      expect(record.early_span).to eq 2.hours
    end

    it 'drops before 5:00' do
      record.started_at = Time.zone.parse('03:00')
      record.finished_at = Time.zone.parse('06:00')
      record.save
      expect(record.early_span).to eq 1.hours
    end

    it 'drops if starts after 7:45' do
      record.started_at = Time.zone.parse('07:45')
      record.finished_at = Time.zone.parse('09:00')
      record.save
      expect(record.early_span).to eq 0.hours
    end

    it 'takes from 5:00 to 8:00 when crossing multiple days' do
      record.started_at = Time.zone.parse('23:00') - 3.day
      record.finished_at = Time.zone.parse('10:00')
      record.save
      expect(record.early_span).to eq 9.hours
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

  describe '#ensure_late_span' do
    it 'sets span' do
      record.started_at = Time.zone.parse('22:00')
      record.finished_at = Time.zone.parse('23:23')
      record.save
      expect(record.late_span).to eq 1.hours + 23.minutes
    end

    it 'drops after 5:00' do
      record.started_at = Time.zone.parse('03:00')
      record.finished_at = Time.zone.parse('10:23')
      record.save
      expect(record.late_span).to eq 2.hours
    end

    it 'drops before 22:00' do
      record.started_at = Time.zone.parse('21:00')
      record.finished_at = Time.zone.parse('23:00')
      record.save
      expect(record.late_span).to eq 1.hours
    end

    it 'takes even if starts after 4:45' do
      record.started_at = Time.zone.parse('4:45')
      record.finished_at = Time.zone.parse('05:00')
      record.save
      expect(record.late_span).to eq 15.minutes
    end

    it 'takes from 22:00 to 5:00 when crossing multiple days' do
      record.started_at = Time.zone.parse('20:00') - 3.day
      record.finished_at = Time.zone.parse('10:00')
      record.save
      expect(record.late_span).to eq 21.hours
    end

    it 'sets nil if finished_at is abasent' do
      record.started_at = Time.zone.parse('22:00')
      record.finished_at = Time.zone.parse('23:23')
      record.save
      record.finished_at = nil
      record.save
      expect(record.late_span).to eq nil
    end
  end
end

RSpec.describe Record, type: :model do
  it_behaves_like RecordSpanCalculator
end
