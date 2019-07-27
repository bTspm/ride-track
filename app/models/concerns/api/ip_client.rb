module Api
  class IpClient < Client
    def initialize
      super(url: _url)
    end

    def get_details(ip)
      url = "#{ip}?fields=8421376"
      get(url: url, cache_key: ip)
    end

    private

    def _url
      'http://ip-api.com/json/'
    end
  end
end

