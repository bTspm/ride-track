module Domains::Currency
  class Currency

    attr_reader :code,
                :name,
                :symbol

    def initialize(code:, name:, symbol:)
      @code = code
      @name = name
      @symbol = symbol
    end
  end
end
