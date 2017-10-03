module RecordWorkingHours
  extend ActiveSupport::Concern

  YEARLY_REGULAR_WORKING_HOURS = 2085
  YEARLY_DAYS = 365

  module ClassMethods
    def regular_working_hours_to date
      days = (date.to_date - date.beginning_of_year.to_date).to_i
      YEARLY_REGULAR_WORKING_HOURS.hours * (days / YEARLY_DAYS.to_f)
    end
  end
end
