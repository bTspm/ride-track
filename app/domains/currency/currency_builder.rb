module Domains::Currency
  class CurrencyBuilder

    attr_reader :currencies,
                :exchange_rate,
                :histories

    def initialize(countries:, currencies:, exchange_rate:, histories:)
      @countries = countries
      @currencies = currencies
      @exchange_rate = exchange_rate
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

    def grouped_currencies
      @grouped_currencies ||= @countries.group_by { |c| c.currency.code }
    end
  end
end

