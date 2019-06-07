module Domains::Currency
  class HistoryResponse

    attr_reader :from,
                :to,
                :histories

    def initialize(details = {})
      @details   = details
      @from      = @details[:fr]
      @to        = @details[:to]
      @histories = _histories
    end

    private

    def _histories
      @details[:val].map do |k, v|
        Domains::Currency::History.new({date: k, rate: v})
      end
    end
  end
end

