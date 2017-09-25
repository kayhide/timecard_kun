module RecordSpanCalculator
  extend ActiveSupport::Concern

  SPLIT_POINT_OFFSET = 8.hours
  BREAK_TIME_THREASHOLD = 6.hours
  BREAK_TIME_SPAN = 1.hours

  included do
    before_validation :ensure_regular_span
    before_validation :ensure_early_span
  end

  private

  def ensure_regular_span
    if started_at_changed? || finished_at_changed?
      if finished_at
        self.regular_span = [0, finished_at - computed_started_at].max
        take_break_time
      else
        self.regular_span = nil
      end
    end
  end

  def take_break_time
    if regular_span && regular_span > BREAK_TIME_THREASHOLD
      self.regular_span -= BREAK_TIME_SPAN
    end
  end

  def ensure_early_span
    if started_at_changed? || finished_at_changed?
      if finished_at
        x = [split_point, finished_at].min
        self.early_span = [0, x - computed_started_at].max
      else
        self.early_span = nil
      end
    end
  end

  def split_point
    @split_point ||= finished_at.beginning_of_day + SPLIT_POINT_OFFSET
  end
end
