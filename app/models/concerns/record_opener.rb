module RecordOpener
  extend ActiveSupport::Concern

  included do
    include RecordBase
  end

  module ClassMethods
    def open user_id
      params = {
        staff: user_id,
        flag: 1
      }
      agent = Mechanize.new
      agent.basic_auth(*basic_authentication)
      agent.get(URI.join(base_url, 'regist.php'), params)
    end

    def close user_id
      params = {
        staff: user_id,
        flag: 0
      }
      agent = Mechanize.new
      agent.basic_auth(*basic_authentication)
      agent.get(URI.join(base_url, 'regist.php'), params)
    end
  end
end
