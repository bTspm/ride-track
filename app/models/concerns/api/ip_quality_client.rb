module Api
  class IpQualityClient < Client
    def initialize
      super(url: _url)
    end

    def get_details(ip)
      cache_key = "#{ip}-quality"
      url = "#{ip}?strictness=3"
      get(url: url, cache_key: cache_key, expire_time: ONE_DAY)
    end

    private

    def _key
      'XvRqsFHrjzwdL0tJLzMMYSQUOgXnpMGG'
    end

    def _url
      "https://www.ipqualityscore.com/api/json/ip/XvRqsFHrjzwdL0tJLzMMYSQUOgXnpMGG/"
    end
  end
end

