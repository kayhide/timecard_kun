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
        self.regular_span = [0, finished_at - started_at].max
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
        spans = Enumerator.new do |y|
          x = started_at
          while x < finished_at
            x1 = [finished_at, x.beginning_of_day + SPLIT_POINT_OFFSET].min
            y << [0, x1 - x].max
            x = x.beginning_of_day + 1.day
          end
        end
        self.early_span = spans.sum
      else
        self.early_span = nil
      end
    end
  end
end
