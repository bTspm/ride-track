module Domains::Currency
  class Currency

    attr_reader :code,
                :name,
                :symbol,
                :countries

    def initialize(details = {})
      @code = details[:code]
      @name = details[:name]
      @symbol = details[:symbol]
    end

    def countries=(countries)
      @countries = countries
    end
  end
end

