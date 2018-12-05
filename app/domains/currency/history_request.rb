module Domains::Currency
  class HistoryRequest

    attr_reader :to_currency_code, :from_currency_code, :start_date, :end_date
    def initialize(to_currency_code:, from_currency_code:)
      @to_currency_code = to_currency_code
      @from_currency_code = from_currency_code
      @end_date = Date.today
      @start_date = Date.today - 8.days
    end
  end
end
