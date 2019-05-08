module Domains::Currency
  class History

    attr_reader :date, :rate
    def initialize(details ={})
      @date = details[:date]
      @rate = details[:rate]
    end
  end
end
