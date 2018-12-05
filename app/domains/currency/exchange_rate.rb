module Domains::Currency
  class ExchangeRate

    attr_reader :to_currency_code,
                :from_currency_code,
                :to_rate,
                :from_rate

    def initialize(response:)
      @to_currency_code = response[:to]
      @from_currency_code = response[:fr]
      @to_rate = response[:val]
      @from_rate = 1
    end
  end
end
