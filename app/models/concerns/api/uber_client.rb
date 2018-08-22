module Api
  class UberClient < Client

    def get_price_estimates(start_latitude:, start_longitude:, end_latitude:, end_longitude:)
      url = url_prefix + '/estimates/price?'
      cache_key = "uber-#{start_latitude}+#{start_longitude}+#{end_latitude}+#{end_longitude}"
      url = url + "start_latitude=#{start_latitude}&"
      url = url + "start_longitude=#{start_longitude}&"
      url = url + "end_latitude=#{end_latitude}&"
      url = url + "end_longitude=#{end_longitude}"
      url = url + access_key
      _get(url: url, cache_key: cache_key)
    end

    def get_products(latitude:, longitude:)
      cache_key = "uber-#{latitude}+#{longitude}"
      url = url_prefix + '/products?'
      url = url + "latitude=#{latitude}&"
      url = url + "longitude=#{longitude}"
      url = url + access_key
      _get(url: url, cache_key: cache_key)
    end

    private

    URL = 'https://api.uber.com/'.freeze
    VERSION = 'v1.2'.freeze

    attr_reader :conn

    def url_prefix
      URL + VERSION
    end

    def access_key
      '&access_token=KA.eyJ2ZXJzaW9uIjoyLCJpZCI6IlBJTkdGOEFSVHhhWWZ4dDNiTU1TOXc9PSIsImV4cGlyZXNfYXQiOjE1MzUwNjc2NTAsInBpcGVsaW5lX2tleV9pZCI6Ik1RPT0iLCJwaXBlbGluZV9pZCI6MX0.Xf3XmglGjx-v4WB2ZZDB5JLK_EiOXm6N0xEOpIeXL6s'
    end

  end
end