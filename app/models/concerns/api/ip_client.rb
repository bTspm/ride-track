module Api
  class IpClient < Client
    def initialize
      super(url: _url)
    end

    def get_details(ip_or_domain)
      url = "#{ip_or_domain}?fields=12845055"
      get(url: url, cache_key: ip_or_domain, expire_time: ONE_DAY)
    end

    private

    def _url
      'http://ip-api.com/json/'
    end
  end
end

