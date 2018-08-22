module Domains::RideTrack
  class BasePriceEstimate

    def average_estimate
      ((low_estimate || 1)  + (high_estimate || 1)) / 2
    end

  end
end