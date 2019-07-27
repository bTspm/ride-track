module Domains::Currency
  class ExchangeRate

    attr_reader :from,
                :from_currency,
                :rate,
                :to,
                :to_currency

    def initialize(response = {})
      @from = response[:fr]
      @to = response[:to]
      @rate = response[:val]
    end

    def from_currency=(from)
      @from_currency = from
    end

    def to_currency=(to)
      @to_currency = to
    end
  end
end

