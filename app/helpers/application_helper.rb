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

  def format_span span
    h = span / 3600
    m = span % 3600 / 60
    s = span % 60
    format('%d:%02d:%02d', h, m, s)
  end
end
