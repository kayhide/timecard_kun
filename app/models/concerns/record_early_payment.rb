module RecordEarlyPayment
  extend ActiveSupport::Concern

  EARLY_PAYMENT_PER_HOUR = 100

  def early_payment
    self.class.early_payment early_span
  end

  module ClassMethods
    def early_payment span
      (span * 100.0 / 3600).to_i
    end
  end
end
