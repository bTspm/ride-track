module Domains::RideTrack
  class BaseProduct

    def cancellation_fee
      'Unknown'
    end

    def has_price_details?
      false
    end

  end
end