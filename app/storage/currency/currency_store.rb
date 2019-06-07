module Storage::Currency
  class CurrencyStore
    def get_countries_with_currencies
      response = client.get_countries_with_currencies
      validate_response(response)
      build_countries(response)
    end

    def get_currencies
      response = client.get_currencies
      validate_response(response)
      build_currencies(response)
    end

    def get_exchange_rate(from:, to:)
      response = client.get_exchange_rate(from: from, to: to)
      validate_response(response)
      build_exchange_rate(response)
    end

    def get_history(from:, to:, start_date:, end_date:)
      response = client.get_history(to: to, from: from, start_date: start_date, end_date: end_date)
      validate_response(response)
      build_histories(response)
    end

    def get_exchange_rate_on_pairs(pairs)
      response = client.get_exchange_rate_on_pairs(pairs)
      validate_response(response)
      build_exchange_rate_on_pairs(response)
    end

    private

    def client
      Api::CurrencyClient.new
    end

    def validate_response(response)
      return if response.success
      raise Exceptions::AppExceptions::ApiError.new(message: response.body[:error])
    end

    def build_exchange_rate(response)
      return if response.body[:results].blank?
      Domains::Currency::ExchangeRate.new(response.body[:results].first.last)
    end

    def build_countries(response)
      response.body[:results].map do |k, v|
        Domains::Currency::Country.new(v)
      end
    end

    def build_currencies(response)
      response.body[:results].map do |k, v|
        Domains::Currency::Currency.new({code: k, name: v[:currencyName], symbol: v[:currencySymbol]})
      end
    end

    def build_histories(response)
      Domains::Currency::HistoryResponse.new(response.body[:results].values.first)
    end

    def build_exchange_rate_on_pairs(response)
      return if response.body[:results].blank?
      response.body[:results].values.map do |result|
        Domains::Currency::ExchangeRate.new(result)
      end
    end
  end
end
