module Domains::Currency
  class HomeBuilder

    attr_reader :request, :dates, :rates
    def initialize(request)
      @request = request
    end

    def histories=(histories)
      @histories = histories
    end

    def build
      return if @histories.blank?
      @dates = sorted_histories.map(&:date)
      @rates = sorted_histories.map(&:rate)
    end

    private

    def sorted_histories
      @sorted_histories ||= @histories.sort_by{|h| h.date}
    end
  end
end
