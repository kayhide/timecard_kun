class AdminController < ApplicationController
  layout 'admin'

  protected

  def set_cour
    year = params[:year].try(&:to_i)
    month = params[:month].try(&:to_i)
    date = (year && month) ? Date.new(year, month, Record::COUR_START_DAY) : Date.current
    @cour = Record.cour_of(date)
  end
end
