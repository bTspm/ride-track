module Api
  class CurrencyClient < Client

    def initialize
      super(url: URL)
    end

    def get_countries_with_currencies
      cache_key = "countries"
      url = "#{VERSION}/countries?apiKey=#{KEY}"
      get(url: url, cache_key: cache_key, expire_time: one_day)
    end

    def get_currencies
      cache_key = "currencies"
      url = "#{VERSION}/currencies?apiKey=#{KEY}"
      get(url: url, cache_key: cache_key, expire_time: one_day)
    end

    def get_exchange_rate(from:, to:)
      cache_key = "exchange_rate-#{from}-#{to}"
      url = "#{VERSION}/convert?q=#{from}_#{to}&apiKey=#{KEY}"
      get(url: url, cache_key: cache_key, expire_time: _calc_cache_expire_time_for_top_of_hour)
    end

    def get_exchange_rate_on_pairs(pairs)
      cache_key = "pairs-#{pairs}"
      url = "#{VERSION}/convert?q=#{pairs}&apiKey=#{KEY}"
      get(url: url, cache_key: cache_key, expire_time: _calc_cache_expire_time_for_top_of_hour)
    end

    def get_history(from:, to:, start_date:, end_date:)
      cache_key = "history-#{from}-#{to}-#{start_date}-#{end_date}"
      url = "#{VERSION}/convert?q=#{from}_#{to}&date=#{start_date}&endDate=#{end_date}&apiKey=#{KEY}"
      get(url: url, cache_key: cache_key, expire_time: one_day)
    end

    private

    def _calc_cache_expire_time_for_top_of_hour
      (3_600 - (Time.now.utc - Time.now.utc.beginning_of_hour)).ceil(0)
    end

    URL = 'https://free.currconv.com/api/'.freeze
    VERSION = 'v7'.freeze
    KEY = 'eb122e3e7f73af020825'

  end
end

