class Admin::RecordsController < AdminController
  before_action :set_cour

  # GET /admin/records
  def index
    @records =
      Record.cour(@cour)
            .includes(:user)
            .order(started_at: :asc)

    @boy_to_eoc_regular_span_sums =
      Record.where(finished_at: @cour.last.beginning_of_year ... @cour.last)
            .group(:user_id)
            .sum(:regular_span)
  end

  private

  def set_cour
    year = params[:year].try(&:to_i)
    month = params[:month].try(&:to_i)
    date = (year && month) ? Date.new(year, month, Record::COUR_START_DAY) : Date.current
    @cour = Record.cour_of(date)
  end
end
