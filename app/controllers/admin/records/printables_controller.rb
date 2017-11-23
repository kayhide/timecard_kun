class Admin::Records::PrintablesController < AdminController
  layout 'printable'
  before_action :set_cour

  # GET /admin/records/printables
  def index
    @users = User.without_hidden.order(id: :asc)
    @records =
      Record.cour(@cour)
            .finished
            .includes(:user)
            .order(started_at: :asc)
            .group_by(&:user_id)

    @boy_to_eoc_regular_span_sums =
      Record.where(started_at: @cour.last.beginning_of_year ... @cour.last)
            .group(:user_id)
            .sum(:regular_span)
  end
end
