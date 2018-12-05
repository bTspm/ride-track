module Domains::Currency
  class Country

    attr_reader :name,
                :code,
                :alpha_code,
                :currency

    def initialize(details:)
      @details = details
      @name = details[:name]
      @code = details[:id]
      @alpha_code = details[:alpha3]
      @currency = create_currency
    end

    private

    def create_currency
      Domains::Currency::Currency.new(
          code: @details[:currencyId],
          name: @details[:currencyName],
          symbol: @details[:currencySymbol]
      )
    end
  end
end
