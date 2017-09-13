class RecordsController < ApplicationController
  # GET /records
  def index
    year = params[:year].try(&:to_i)
    month = params[:month].try(&:to_i)
    @start_date = Record.adjusted_start_date(year, month)
    @records = Record.get_monthly_details(@start_date)
  end
end
