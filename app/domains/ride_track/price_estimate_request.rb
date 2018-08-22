module Domains::RideTrack
  class PriceEstimateRequest

    attr_reader :origin, :destination

    def initialize(origin_details:, destination_details:)
      @origin = Domains::Address.new(details: origin_details)
      @destination = Domains::Address.new(details: destination_details)
    end

  end
end