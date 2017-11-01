module RecordStartSetter
  extend ActiveSupport::Concern

  included do
    before_validation :ensure_started_at
  end

  private

  def ensure_started_at
    if !started_at || finished_at
      self.started_at = computed_started_at
      self.is_start_implicit = true
    end
  end
end
