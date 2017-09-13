module ApplicationHelper
  def months start_date, end_date
    date = start_date.beginning_of_month
    Enumerator.new do |y|
      while date < end_date
        y << date
        date = date + 1.month
      end
    end
  end
end
