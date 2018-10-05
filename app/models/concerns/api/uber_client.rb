module Api
  class UberClient < Client

    def initialize
      super(url: URL, auth_type: TOKEN, auth_options: {token: 'qAOTxuARNpS_FZbOQIlqrW9_dCSYaRRRmqUSktFl'})
    end

    def get_price_estimates(start_latitude:, start_longitude:, end_latitude:, end_longitude:)
      cache_key = "uber-#{start_latitude}+#{start_longitude}+#{end_latitude}+#{end_longitude}"

      url = VERSION + '/estimates/price?'
      url = url + "start_latitude=#{start_latitude}&"
      url = url + "start_longitude=#{start_longitude}&"
      url = url + "end_latitude=#{end_latitude}&"
      url = url + "end_longitude=#{end_longitude}"
      _get(url: url, cache_key: cache_key)
    end

    def get_products(latitude:, longitude:)
      cache_key = "uber-#{latitude}+#{longitude}"

      url = VERSION + '/products?'
      url = url + "latitude=#{latitude}&"
      url = url + "longitude=#{longitude}"
      _get(url: url, cache_key: cache_key)
    end

    private

    URL = 'https://api.uber.com/'.freeze
    VERSION = 'v1.2'.freeze

  end
end