class Admin::RecordsController < AdminController
  before_action :set_cour

  # GET /admin/records
  def index
    @records =
      Record.cour(@cour)
            .includes(:user)
            .order(finished_at: :asc)

    @boy_to_eoc_regular_span_sums =
      Record.where(finished_at: @cour.last.beginning_of_year ... @cour.last)
            .group(:user_id)
            .sum(:regular_span)
  end
end
