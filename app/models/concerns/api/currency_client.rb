module Api
  class CurrencyClient < Client

    def initialize
      super(url: url_prefix)
    end

    def get_countries_with_currencies
      url = "#{version}/countries?apiKey=#{key}"
      get(url: url, cache_key: "countries", expire_time: Api::CacheTime::ONE_DAY)
    end

    def get_currencies
      url = "#{version}/currencies?apiKey=#{key}"
      get(url: url, cache_key: "currencies", expire_time: Api::CacheTime::ONE_DAY)
    end

    def get_exchange_rate(from:, to:)
      cache_key = "exchange_rate-#{from}-#{to}"
      url = "#{version}/convert?q=#{from}_#{to}&apiKey=#{key}"
      get(url: url, cache_key: cache_key, expire_time: calc_top_of_hour)
    end

    def get_exchange_rate_on_pairs(pairs_string)
      cache_key = "pairs-#{pairs_string}"
      url = "#{version}/convert?q=#{pairs_string}&apiKey=#{key}"
      get(url: url, cache_key: cache_key, expire_time: calc_top_of_hour)
    end

    def get_history(args={})
      cache_key = "history-#{args[:from]}-#{args[:to]}-#{args[:start_date]}-#{args[:end_date]}"
      url = "#{version}/convert?q=#{args[:from]}_#{args[:to]}"
      url += "&date=#{args[:start_date]}&endDate=#{args[:end_date]}&apiKey=#{key}"
      get(url: url, cache_key: cache_key, expire_time: Api::CacheTime::ONE_DAY)
    end

    private

    def key
      'eb122e3e7f73af020825'
    end
    
    def url_prefix
      'https://free.currconv.com/api/'
    end
    
    def version
      'v7'
    end
  end
end

