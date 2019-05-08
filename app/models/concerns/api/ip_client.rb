module Api
  class IpClient < Client
    def initialize
      super(url: URL)
    end

    def get_details(ip)
      get(url: ip, cache_key: ip, expire_time: one_day)
    end

    private

    URL = 'http://ip-api.com/json/'.freeze
  end
end

