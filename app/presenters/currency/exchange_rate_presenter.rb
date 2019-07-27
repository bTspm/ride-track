module Presenters::Currency
  class ExchangeRatePresenter
    include Btspm::Presenters::Presentable

    class Scalar < Btspm::Presenters::ScalarPresenter

      def from_currency
        _currency_presenter(data_object.from_currency)
      end

      def from_currency_base(number)
        "#{number} #{from}"
      end

      def from_currency_calc_amount(number)
        "#{(number * to_rounded_rate).round(5)} #{to}"
      end

      def to_currency
        _currency_presenter(data_object.to_currency)
      end

      def to_currency_base(number)
        "#{number} #{to}"
      end

      def to_currency_calc_amount(number)
        "#{(number / to_rounded_rate).round(5)} #{from}"
      end

      def to_rounded_rate
        (rate.to_f).round(5)
      end

      private

      def _currency_presenter(currency)
        ::Presenters::Currency::CurrenciesPresenter.present(currency, h)
      end
    end

    class Enum < Btspm::Presenters::EnumPresenter
      def rate_by_currency(to_code:, from_code:)
        return 1 if to_code.downcase == from_code.downcase
        data_object.find{ |exchange_rate| exchange_rate.from == from_code && exchange_rate.to == to_code }&.rate
      end
    end
  end
end

