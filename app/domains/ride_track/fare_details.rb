module Domains::RideTrack
  class FareDetails

    def initialize(products:, estimates:)
      @products = products
      @estimates = estimates
    end

    def distance_unit
      products.map(&:distance_unit).first
    end

    def minimum_distance
      estimates.map(&:distance_in_unit).min
    end

    def minimum_duration_in_minutes
      estimates.map(&:duration_in_minutes).min
    end

    private

    attr_reader :products, :estimates

  end
end