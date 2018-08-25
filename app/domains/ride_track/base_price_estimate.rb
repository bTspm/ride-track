module Domains::RideTrack
  class BasePriceEstimate

    def average_estimate
      ((low_estimate || 1)  + (high_estimate || 1)) / 2.0
    end

    def provider
      raise NotImplementedError
    end

    def currency_code
      raise NotImplementedError
    end

  end
end