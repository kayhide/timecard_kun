class Record < ApplicationRecord
  include RecordSpanCalculator
  include RecordWorkingHours

  belongs_to :user

  COUR_START_DAY = 21
  DAY_BEGINNING_OFFSET = 2.hours
  DEFAULT_STARTED_AT_OFFSET = 8.hours

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
  scope :unfinished, ->() {
    where(finished_at: nil)
  }
  scope :recent, ->() {
    x = (Time.current - DAY_BEGINNING_OFFSET).beginning_of_day + DAY_BEGINNING_OFFSET
    where(started_at: x .. Float::INFINITY)
  }

  def unfinished?
    !finished_at?
  end

  def computed_started_at
    started_at ||
      finished_at &&
      (finished_at - DEFAULT_STARTED_AT_OFFSET).beginning_of_day + DEFAULT_STARTED_AT_OFFSET
  end
end
