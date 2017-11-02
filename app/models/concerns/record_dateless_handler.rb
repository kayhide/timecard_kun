module RecordDatelessHandler
  extend ActiveSupport::Concern


  included do
    attribute :dateless_started_at, :time
    attribute :dateless_finished_at, :time
    before_validation :handle_dateless
  end

  private

  def handle_dateless
    return unless started_at

    date = started_at.beginning_of_day
    if dateless_started_at
      self.started_at = date + dateless_started_at.seconds_since_midnight
    end
    if dateless_finished_at
      self.finished_at = date + dateless_finished_at.seconds_since_midnight
      self.finished_at += 1.day if started_at > finished_at
    elsif dateless_finished_at_before_type_cast == ''
      self.finished_at = nil
    end
  end
end
