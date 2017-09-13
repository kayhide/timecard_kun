class RecordsController < ApplicationController
  # GET /records
  def index
    month = params[:month].try(&:to_i)
    @start_date = Record.adjusted_start_date(month)
    @records = Record.get_monthly_details(@start_date)
  end
end
