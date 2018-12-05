module Storage::Currency
  class CurrencyStore
    def get_countries_with_currencies
      response = client.get_countries_with_currencies
      validate_response(response: response)
      build_countries(response: response)
    end

    def get_exchange_rate(to:, from:)
      response = client.get_exchange_rate(to: to, from: from)
      validate_response(response: response)
      build_exchange_rate(response: response)
    end

    def get_history(to:, from:, start_date:, end_date:)
      response = client.get_history(to: to, from: from, start_date: start_date, end_date: end_date)
      validate_response(response: response)
      build_histories(response: response)
    end

    private

    def client
      Api::CurrencyClient.new
    end

    def validate_response(response:)
      return if response.success
      raise Exceptions::AppExceptions::ApiError.new(message: response.body[:error])
    end

    def build_exchange_rate(response:)
      return if response.body[:results].blank?
      Domains::Currency::ExchangeRate.new(response: response.body[:results].first.last)
    end

    def build_countries(response:)
      response.body[:results].map do |k, v|
        Domains::Currency::Country.new(details: v)
      end
    end

    def build_histories(response:)
      response.body[:results].first.last[:val].map do |k, v|
        Domains::Currency::History.new(date: k, rate: v)
      end
    end
  end
end
