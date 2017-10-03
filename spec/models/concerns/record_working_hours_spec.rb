require 'rails_helper'

RSpec.shared_examples RecordWorkingHours do
  let(:date) { Date.new(2017, 9, 25) }

  describe '.regular_working_hours_to' do
    it 'returns regular working hours from beginning of the year to given date' do
      days = date - date.beginning_of_year
      expect(Record.regular_working_hours_to(date).to_i).to eq (2085.hours * (days / 365.0)).to_i
    end
  end
end

RSpec.describe Record, type: :model do
  it_behaves_like RecordWorkingHours
end
