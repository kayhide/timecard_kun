module RecordFetcher
  extend ActiveSupport::Concern

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

    def base_url
      'http://skylon.jp/timecard/timeline.php'
    end

    def basic_authentication
      [ENV['RECORD_FETCHER_USERNAME'], ENV['RECORD_FETCHER_PASSWORD']]
    end

    def closing_day
      20
    end

    def request params
      agent = Mechanize.new
      agent.basic_auth(*basic_authentication)
      agent.get(base_url, params)
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

    def adjusted_start_date month = nil
      today = Date.today
      start = Date.new today.year, (month || today.month), closing_day
      if start.future?
        if start.month == today.month
          start = start - 1.month
        else
          start = start - 1.year
        end
      end
      start
    end
  end
end
