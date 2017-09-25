class Record < ApplicationRecord
  belongs_to :user

  COUR_START_DAY = 21

  def self.cour_of time
    starts_on = Time.zone.local(time.year, time.month, COUR_START_DAY)
    starts_on -= 1.month if time.day < COUR_START_DAY
    ends_on = starts_on + 1.month
    starts_on ... ends_on
  end

  scope :cour, ->(range) {
    where(finished_at: range)
  }
  scope :current_cour, ->() {
    cour(cour_of(Time.current))
  }
  scope :last_cour, ->() {
    cour(cour_of(Time.current - 1.month))
  }
end
