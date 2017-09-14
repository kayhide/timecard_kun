class RecordsController < ApplicationController
  before_action :keep_user_info, only: [:new]

  # GET /records
  def index
    year = params[:year].try(&:to_i)
    month = params[:month].try(&:to_i)
    @start_date = Record.adjusted_start_date(year, month)
    @records = Record.get_monthly_details(@start_date)
  end

  # GET /records/new
  def new
    unless user_id && user_name
      redirect_to action: :index
    end
  end

  # POST /records/open
  def open
    unless user_id
      redirect_to action: :index
    end
    Record.open user_id
    redirect_to action: :new
  end

  # POST /records/close
  def close
    unless user_id
      redirect_to action: :index
    end
    Record.close user_id
    redirect_to action: :new
  end
end
