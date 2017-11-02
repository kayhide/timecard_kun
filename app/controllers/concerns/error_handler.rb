module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  end

  def handle_record_invalid e
    render json: { error_message: e.message }, status: :unprocessable_entity
  end
end
