module Services
  class CurrencyService < BusinessService
    include Services

    def get_currencies
      _currencies
    end

    def get_currencies_from_ip(ip)
      countries = get_countries_from_ip(ip)
      from      = get_currency_from_country(countries[:from])
      to        = get_currency_from_country(countries[:to])
      {from: from.code, to: to.code}
    end

    def get_currency_histories(from:, to:)
      get_history_from_request(Domains::Currency::HistoryRequest.new(from: from, to: to))
    end

    def get_exchange_rate(from:, to:)
      currency_storage.get_exchange_rate(from: from, to: to)
    end

    def get_exchange_rate_with_currency_details(from:, to:)
      exchange_rate = get_exchange_rate(from: from, to: to)
      _add_currency_details_to_exchange_rate(exchange_rate)
    end

    def get_history_from_request(request)
      currency_storage.get_history(
        to:         request.to,
        from:       request.from,
        start_date: request.start_date,
        end_date:   request.end_date
      )
    end

    def get_popular_currency_exchanges(from)
      # pairs = _currency_pairs(from).map do |pairs|
      #   currency_storage.get_exchange_rate_on_pairs(pairs)
      # end
      pairs = currency_storage.get_exchange_rate_on_pairs(_currency_pairs(from))
      pairs.flatten
    end

    private

    def get_countries_from_ip(ip)
      address = get_address_from_ip(ip)
      return Constants::Currency::DEFAULT_FROM_AND_TO if address.blank? || address.is_us?
      {from: Constants::Currency::DEFAULT_FROM, to: address.country_code}
    end

    def get_address_from_ip(ip)
      ip_storage.get_ip_details(ip).address
    rescue Exceptions::AppExceptions::ApiError
      nil
    end

    def get_currency_from_country(code)
      _countries.find { |country| country.code.downcase == code.downcase }.currency
    end

    def add_countries_to_currency_by_code(code)
      currency           = get_currency_from_code(code)
      currency.countries = _get_countries_by_currency(code)
      currency
    end

    def get_currency_from_code(code)
      _currencies.find { |currency| currency.code.downcase == code.downcase }
    end

    def _countries
      @countries ||= currency_storage.get_countries_with_currencies
    end

    def _currencies
      @currencies ||= currency_storage.get_currencies.sort_by(&:name)
    end

    def _add_currency_details_to_exchange_rate(exchange_rate)
      exchange_rate.from_currency = add_countries_to_currency_by_code(exchange_rate.from)
      exchange_rate.to_currency   = add_countries_to_currency_by_code(exchange_rate.to)
      exchange_rate
    end

    def _get_countries_by_currency(code)
      @countries_by_currency ||= _countries.group_by { |c| c.currency.code }
      @countries_by_currency["#{code}"]
    end

    def _currency_pairs(from)
      pairs = ""
      Constants::Currency::POPULAR_CURRENCIES.each do |currency|
        next if from.downcase == currency.downcase
        pairs << "#{from}_#{currency},#{currency}_#{from},"
      end
      pairs.chomp(',')
    end
  end
end

