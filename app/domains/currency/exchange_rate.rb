module Domains::Currency
  class ExchangeRate

    attr_reader :to_rate,
                :from_rate,
                :to_currency,
                :from_currency,
                :from,
                :to

    def initialize(response = {})
      @from = response[:fr]
      @to = response[:to]
      @to_rate = response[:val]
      @from_rate = 1
    end

    def from_currency=(from)
      @from_currency = from
    end

    def to_currency=(to)
      @to_currency = to
    end
  end
end

