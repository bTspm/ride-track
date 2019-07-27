module Services
  class CurrencyService < BusinessService
    include Services

    def get_currencies
      _currencies
    end

    def get_currencies_from_ip(ip)
      currency_code = _get_local_currency_from_ip(ip)
      return Constants::Currency::DEFAULT_FROM_AND_TO if _use_default_currencies?(currency_code)
      {from: Constants::Currency::DEFAULT_FROM, to: currency_code}
    end

    def get_currency_histories(args = {})
      args.merge!(_history_date_args(args))
      currency_storage.get_history(args)
    end

    def get_exchange_rate(from:, to:)
      currency_storage.get_exchange_rate(from: from, to: to)
    end

    def get_exchange_rate_with_currency_details(from:, to:)
      exchange_rate = get_exchange_rate(from: from, to: to)
      _add_currency_details_to_exchange_rate(exchange_rate)
    end

    def get_popular_currency_exchanges(from)
      # pairs = _currency_pairs(from).map do |pairs|
      #   currency_storage.get_exchange_rate_on_pairs(pairs)
      # end
      pairs = currency_storage.get_exchange_rate_on_pairs(_currency_pairs(from))
      pairs.flatten
    end

    private

    def _add_countries_to_currency_by_code(code)
      currency = _get_currency_from_code(code)
      currency.countries = _get_countries_by_currency(code)
      currency
    end

    def _add_currency_details_to_exchange_rate(exchange_rate)
      exchange_rate.from_currency = _add_countries_to_currency_by_code(exchange_rate.from)
      exchange_rate.to_currency = _add_countries_to_currency_by_code(exchange_rate.to)
      exchange_rate
    end

    def _countries
      @countries ||= currency_storage.get_countries_with_currencies
    end

    def _currencies
      @currencies ||= currency_storage.get_currencies.sort_by(&:name)
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

    def _get_currency_from_code(code)
      _currencies.find { |currency| currency.code.downcase == code.downcase }
    end

    def _get_local_currency_from_ip(ip)
      ip_storage.get_ip_details(ip).currency_code
    rescue Exceptions::AppExceptions::ApiError
      nil
    end

    def _history_date_args(args)
      {
        end_date: args[:end_date] || Date.today,
        start_date: args[:start_date] || (Date.today - 8.days)
      }
    end

    def _use_default_currencies?(currency_code)
      currency_code.blank? || currency_code == Constants::Currency::DEFAULT_FROM
    end
  end
end

