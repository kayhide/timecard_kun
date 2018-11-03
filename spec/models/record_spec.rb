require 'rails_helper'

RSpec.describe Record, type: :model do
  describe '.cour_of' do
    it 'returns range' do
      date = Time.zone.local(2017, 8, 20)
      range = Record.cour_of(date)
      expect(range.cover?(Time.zone.local(2017, 7, 20))).to eq false
      expect(range.cover?(Time.zone.local(2017, 7, 21))).to eq true
      expect(range.cover?(Time.zone.local(2017, 8, 20))).to eq true
      expect(range.cover?(Time.zone.local(2017, 8, 21))).to eq false
    end

    it 'includes just before ending edge' do
      date = Time.zone.local(2017, 8, 20)
      range = Record.cour_of(date)
      expect(range.cover?(Time.zone.local(2017, 8, 21) - 0.001.seconds)).to eq true
    end
  end

  describe '.cour' do
    it 'selects by started_at' do
      range = Time.zone.local(2017, 8, 21) ... Time.zone.local(2017, 9, 21)
      FactoryBot.create(:record, started_at: Time.new(2017, 8, 20))
      records = [
        FactoryBot.create(:record, started_at: Time.new(2017, 8, 21)),
        FactoryBot.create(:record, started_at: Time.new(2017, 9, 20))
      ]
      expect(Record.cour(range).sort).to eq records
    end
  end

  describe '.current_cour' do
    after do
      Timecop.return
    end

    it 'calls .cour with current cour range' do
      Timecop.freeze(Time.new(2017, 9, 20))
      expect(Record).to receive(:cour)
                          .with(Time.zone.local(2017, 8, 21) ... Time.zone.local(2017, 9, 21))
      Record.current_cour
    end
  end

  describe '.last_cour' do
    after do
      Timecop.return
    end

    it 'calls .cour with last cour range' do
      Timecop.freeze(Time.new(2017, 9, 20))
      expect(Record).to receive(:cour)
                          .with(Time.zone.local(2017, 7, 21) ... Time.zone.local(2017, 8, 21))
      Record.last_cour
    end
  end

  describe '.recent' do
    after do
      Timecop.return
    end

    it 'selects by started_at of after 2:00 today' do
      Timecop.freeze(Time.zone.parse('2017-09-20 10:00:00'))
      FactoryBot.create(:record, started_at: Time.zone.parse('2017-09-20 01:59:59'))
      records = [
        FactoryBot.create(:record, started_at: Time.zone.parse('2017-09-20 02:00:00')),
        FactoryBot.create(:record, started_at: Time.zone.parse('2017-09-20 10:00:00'))
      ]
      expect(Record.recent).to eq records
    end

    it 'takes last day when current time is before 2:00' do
      Timecop.freeze(Time.zone.parse('2017-09-20 01:59:59'))
      FactoryBot.create(:record, started_at: Time.zone.parse('2017-09-19 01:59:59'))
      records = [
        FactoryBot.create(:record, started_at: Time.zone.parse('2017-09-19 02:00:00')),
        FactoryBot.create(:record, started_at: Time.zone.parse('2017-09-20 01:59:59'))
      ]
      expect(Record.recent).to eq records
    end
  end

  describe '#computed_started_at' do
    let(:record) { FactoryBot.build(:record, :without_user) }
    let(:today) { Date.new(2017, 9, 25) }

    before do
      Timecop.freeze today
    end

    after do
      Timecop.return
    end

    it 'returns started_at if existing' do
      record.started_at = Time.zone.parse('09:00')
      expect(record.computed_started_at).to eq Time.zone.parse('09:00')
    end

    it 'returns 8:00 of the day of finished_at' do
      record.started_at = nil
      record.finished_at = Time.zone.parse('09:00')
      expect(record.computed_started_at).to eq Time.zone.parse('08:00')
    end

    it 'returns 8:00 of 1 day before when finished_at is before 8:00' do
      record.started_at = nil
      record.finished_at = Time.zone.parse('05:00')
      expect(record.computed_started_at).to eq Time.zone.parse('08:00') - 1.day
    end

    it 'returns nil if started_at and finished_at are both nil' do
      record.started_at = nil
      record.finished_at = nil
      expect(record.computed_started_at).to eq nil
    end
  end
end
