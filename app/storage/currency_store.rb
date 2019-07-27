module Storage
  class CurrencyStore
    def get_countries_with_currencies
      response = client.get_countries_with_currencies
      validate_response(response)
      build_countries(response.body[:results])
    end

    def get_currencies
      response = client.get_currencies
      validate_response(response)
      build_currencies(response.body[:results])
    end

    def get_exchange_rate(from:, to:)
      response = client.get_exchange_rate(from: from, to: to)
      validate_response(response)
      build_exchange_rate(response.body[:results].values.first)
    end

    def get_exchange_rate_on_pairs(pairs_string)
      response = client.get_exchange_rate_on_pairs(pairs_string)
      validate_response(response)
      build_exchange_rate_on_pairs(response.body[:results].values)
    end

    def get_history(args = {})
      response = client.get_history(args)
      validate_response(response)
      build_history_response(response.body[:results].values.first)
    end

    private

    def build_countries(countries)
      countries.values.map do |country|
        Domains::Currency::Country.new(country)
      end
    end

    def build_currencies(currencies)
      currencies.map do |k, v|
        Domains::Currency::Currency.new({code: k, name: v[:currencyName], symbol: v[:currencySymbol]})
      end
    end

    def build_exchange_rate(exchange_rate)
      Domains::Currency::ExchangeRate.new(exchange_rate)
    end

    def build_exchange_rate_on_pairs(exchange_rates)
      exchange_rates.map { |exchange_rate| build_exchange_rate(exchange_rate) }
    end

    def build_history_response(history_response)
      Domains::Currency::HistoryResponse.new(history_response)
    end

    def client
      Api::CurrencyClient.new
    end

    def validate_response(response)
      return if response.success
      raise Exceptions::AppExceptions::ApiError.new(message: response.body[:error])
    end
  end
end

