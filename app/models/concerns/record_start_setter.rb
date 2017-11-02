module RecordStartSetter
  extend ActiveSupport::Concern

  included do
    attribute :started_on, :date
    before_validation :ensure_started_at
  end

  private

  def ensure_started_at
    if !started_at || finished_at
      self.started_at = computed_started_at
      self.is_start_implicit = true
    end

    return unless started_on

    date = started_on.beginning_of_day
    if started_at
      self.started_at = date + started_at.seconds_since_midnight
    end
    if finished_at
      self.finished_at = date + finished_at.seconds_since_midnight
      self.finished_at += 1.day if started_at > finished_at
    end
  end
end
