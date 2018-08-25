module Domains::RideTrack
  class BaseProduct

    def cancellation_fee
      'Unknown'
    end

    def has_price_details?
      false
    end

    def pay_in_cash?
      false
    end

    def shared?
      false
    end

  end
end