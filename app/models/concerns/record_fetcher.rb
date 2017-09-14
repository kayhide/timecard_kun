module RecordFetcher
  extend ActiveSupport::Concern

  included do
    include RecordBase
  end

  module ClassMethods
    def get_monthly_details start_date
      request(detail_params(start_date)).map do |row|
        Record.new(
          id: row[0],
          name: row[1],
          started_at: row[2],
          ended_at: row[3],
          regular_span: row[4],
          early_span: row[5]
        )
      end
    end

    def request params
      agent = Mechanize.new
      agent.basic_auth(*basic_authentication)
      agent.get(URI.join(base_url, 'timeline.php'), params)
      agent.page.css('tr').drop(1).map do |tr|
        data = tr.css('td').map(&:text)
      end
    end

    def detail_params start
      {
        staff: '%%',
        start: start.strftime('%Y/%m/%d'),
        end: (start + 1.month - 1.second).strftime('%Y-%m-%d %H:%M:%S')
      }
    end

    def adjusted_start_date year, month
      today = Date.today
      start = Date.new (year || today.year), (month || today.month), closing_day
      if year.nil? && month.nil? && start.future?
        start = start - 1.month
      end
      start
    end
  end
end
