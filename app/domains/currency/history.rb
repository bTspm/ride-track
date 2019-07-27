module Domains::Currency
  class History

    attr_reader :date, :rate
    def initialize(details ={})
      @date = Date.strptime(details[:date], '%Y-%m-%d')
      @rate = details[:rate]
    end
  end
end

