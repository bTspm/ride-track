module Domains::Currency
  class HistoryRequest

    attr_reader :from,
                :to,
                :start_date,
                :end_date

    def initialize(from:, to:, end_date: default_end_date, start_date: default_start_date)
      @from = from
      @to = to
      @end_date = end_date
      @start_date = start_date
    end

    private

    def default_end_date
      Date.today
    end

    def default_start_date
      default_end_date - 8.days
    end
  end
end

