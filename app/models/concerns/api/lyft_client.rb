module Api
  class LyftClient < Client

    def initialize
      super(url: URL, auth_type: 'Bearer', auth_options: {token: access_token})
    end

    def get_price_estimates(start_latitude:, start_longitude:, end_latitude:, end_longitude:)
      cache_key = "lyft-#{start_latitude}+#{start_longitude}+#{end_latitude}+#{end_longitude}"

      url = VERSION + '/cost?'
      url = url + "start_lat=#{start_latitude}&"
      url = url + "start_lng=#{start_longitude}&"
      url = url + "end_lat=#{end_latitude}&"
      url = url + "end_lng=#{end_longitude}"
      _get(url: url, cache_key: cache_key)
    end

    def get_products(latitude:, longitude:)
      cache_key = "lyft-#{latitude}+#{longitude}"

      url = VERSION + '/ridetypes?'
      url = url + "lat=#{latitude}&"
      url = url + "lng=#{longitude}"
      _get(url: url, cache_key: cache_key)
    end

    private

    URL = 'https://api.lyft.com/'.freeze
    AUTH_PATH = '/oauth/token'.freeze
    VERSION = 'v1'.freeze

    attr_reader :conn

    def access_token
      @access_token ||= client_for_token._post(
          url: AUTH_PATH,
          cache_key: 'lyft-key',
          expire_time: 86400,
          body: auth_params
      ).body[:access_token]
    end

    def client_for_token
      Api::Client.new(
          url: URL,
          auth_type: 'Basic Auth',
          auth_options: {username: 'oOsUibZcOFA6', password: 'G_zZxIMJKmCxOwp8ed51P2jwUgWDpcif'}
      )
    end

    def auth_params
      {grant_type: 'client_credentials', scope: 'public'}
    end

  end
end