module Api
  class CurrencyClient < Client

    def initialize
      super(url: URL)
    end

    def get_countries_with_currencies
      cache_key = "currencies"
      url = "#{VERSION}/countries"
      _get(url: url, cache_key: cache_key)
    end

    def get_exchange_rate(to:, from:)
      cache_key = "exchange_rate-#{to}-#{from}"
      url = "#{VERSION}/convert?q=#{from}_#{to}"
      _get(url: url, cache_key: cache_key)
    end

    def get_history(to:, from:, start_date:, end_date:)
      cache_key = "history-#{to}-#{from}-#{start_date}-#{end_date}"
      url = "#{VERSION}/convert?q=#{from}_#{to}&date=#{start_date}&endDate=#{end_date}"
      _get(url: url, cache_key: cache_key)
    end

    private

    URL = 'https://free.currencyconverterapi.com/api/'.freeze
    VERSION = 'v6'.freeze

  end
end
