module Services
  class CurrencyService < BusinessService
    include Services

    def get_currencies
      _currencies
    end

    def get_exchange_rate_from_ip(ip)
      from_currency, to_currency = get_currencies_from_ip(ip)
      _exchange_rate(from_currency: from_currency, to_currency: to_currency)
    end

    def get_exchange_rate(from:, to:)
      from_currency, to_currency = get_currencies_from_codes(from: from, to: to)
      _exchange_rate(from_currency: from_currency, to_currency: to_currency)
    end

    def get_currency_histories(from:, to:)
      histories = _get_history(Domains::Currency::HistoryRequest.new(from: from, to: to))
      histories.sort_by { |h| h.date }
    end

    private

    def get_currencies_from_ip(ip)
      from_country_code, to_country_code = get_countries_from_ip(ip)
      [get_currency_from_country(from_country_code), get_currency_from_country(to_country_code)]
    end

    def get_countries_from_ip(ip)
      address = get_address_from_ip(ip)
      return Constants::Currency::DEFAULT_FROM_AND_TO if address.blank? || address.is_us?
      [Constants::Currency::DEFAULT_FROM, address.country_code]
    end

    def get_address_from_ip(ip)
      ip_storage.get_ip_details(ip).address
    rescue Exceptions::AppExceptions::ApiError
      nil
    end

    def get_currency_from_country(code)
      _countries.find { |country| (country.code).downcase == code.downcase }.currency
    end

    def get_currencies_from_codes(from:, to:)
      [get_currency_from_code(from), get_currency_from_code(to)]
    end

    def get_currency_from_code(code)
      _currencies.find { |currency| currency.code.downcase == code.downcase }
    end

    def _countries
      @countries ||= currency_storage.get_countries_with_currencies
    end

    def _currencies
      @currencies ||= currency_storage.get_currencies.sort_by { |h| h.name }
    end

    def _get_history(request)
      currency_storage.get_history(
        to:         request.to,
        from:       request.from,
        start_date: request.start_date,
        end_date:   request.end_date
      )
    end

    def _exchange_rate(from_currency:, to_currency:)
      from_currency.countries     = get_countries_by_currency(from_currency.code)
      to_currency.countries       = get_countries_by_currency(to_currency.code)
      exchange_rate               = currency_storage.get_exchange_rate(from: from_currency.code, to: to_currency.code)
      exchange_rate.from_currency = from_currency
      exchange_rate.to_currency   = to_currency
      exchange_rate
    end

    def get_countries_by_currency(code)
      _countries.group_by { |c| c.currency.code }["#{code}"]
    end
  end
end

