module RideTrack
  class FareDetails

    def initialize(products:, estimates:)
      raise ArgumentError.new('both products and estimates are required') if products.blank? || estimates.blank?
      @products = products
      @estimates = estimates
    end

    def distance_unit
      products.map(&:distance_unit).first
    end

    def minimum_distance
      estimates.map(&:distance).min
    end

    def minimum_duration_in_minutes
      estimates.map(&:duration_in_minutes).min
    end

    private

    attr_reader :products, :estimates

  end
end