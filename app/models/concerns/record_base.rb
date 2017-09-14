module RecordBase
  extend ActiveSupport::Concern

  module ClassMethods
    def base_url
      'http://skylon.jp/timecard/'
    end

    def basic_authentication
      [ENV['RECORD_FETCHER_USERNAME'], ENV['RECORD_FETCHER_PASSWORD']]
    end

    def closing_day
      20
    end
  end
end
