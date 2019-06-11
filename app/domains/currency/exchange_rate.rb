module Domains::Currency
  class ExchangeRate

    attr_reader :rate,
                :from_rate,
                :to_currency,
                :from_currency,
                :from,
                :to

    def initialize(response = {})
      @from = response[:fr]
      @to = response[:to]
      @rate = response[:val]
      @from_rate = response[:from_rate] || 1
    end

    def from_currency=(from)
      @from_currency = from
    end

    def to_currency=(to)
      @to_currency = to
    end

    def to_rate
      rate * from_rate
    end
  end
end

