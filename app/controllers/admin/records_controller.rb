class Admin::RecordsController < ApplicationController
  before_action :set_cour

  # GET /admin/records
  def index
    @records = Record.cour(@cour).order(started_at: :asc)
  end

  private

  def set_cour
    year = params[:year].try(&:to_i)
    month = params[:month].try(&:to_i)
    date = (year && month) ? Date.new(year, month, Record::COUR_START_DAY) : Date.current
    @cour = Record.cour_of(date)
  end
end
