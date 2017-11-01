class Admin::Records::PrintablesController < AdminController
  before_action :set_cour

  # GET /admin/records/printables
  def index
    @records =
      Record.cour(@cour)
            .finished
            .includes(:user)
            .order(started_at: :asc)

    @boy_to_eoc_regular_span_sums =
      Record.where(started_at: @cour.last.beginning_of_year ... @cour.last)
            .group(:user_id)
            .sum(:regular_span)
  end
end
