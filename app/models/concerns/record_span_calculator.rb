module RecordSpanCalculator
  extend ActiveSupport::Concern

  EARLY_START_OFFSET = 5.hours
  EARLY_ENDING_OFFSET = 7.hours + 45.minutes
  EARLY_END_OFFSET = 8.hours
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
          d = started_at.beginning_of_day
          while d < finished_at
            r = [d + EARLY_START_OFFSET, d + EARLY_END_OFFSET]
            t0 = [started_at, r.first].max
            t1 = [finished_at, r.last].min
            if t0 < d + EARLY_ENDING_OFFSET && t0 < t1
              y << t1 - t0
            end
            d += 1.day
          end
        end
        self.early_span = spans.sum
      else
        self.early_span = nil
      end
    end
  end
end
