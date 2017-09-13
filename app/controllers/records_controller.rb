class RecordsController < ApplicationController
  # GET /records
  def index
    month = params[:month]
    @records = Record.get(month)
  end
end
