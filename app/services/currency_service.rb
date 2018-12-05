module Services
  class CurrencyService < BusinessService
    include Services

    def get_countries_with_currencies
      currency_storage.get_countries_with_currencies
    end

    def get_exchange_rate(to_currency_code:, from_currency_code:)
      currency_storage.get_exchange_rate(to: to_currency_code, from: from_currency_code)
    end

    def get_history(request:)
      builder = Domains::Currency::HistoryBuilder.new(request: request)
      builder.histories = currency_storage.get_history(
          to: request.to_currency_code,
          from: request.from_currency_code,
          start_date: request.start_date,
          end_date: request.end_date
      )
      builder.build
      builder
    end
  end
end
