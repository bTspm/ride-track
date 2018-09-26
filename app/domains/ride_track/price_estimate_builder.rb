module RideTrack
  class PriceEstimateBuilder

    attr_reader :request
    attr_accessor :estimates, :errors

    def initialize(request:)
      raise ArgumentError.new('request is required') if request.blank?
      @request = request
      @estimates = []
      @errors = []
    end

    def build
      return if estimates.blank?
      sort_estimates_by_price
    end

    def filters
      RideTrack::Filters.new(products: products, estimates: estimates)
    end

    def fare_details
      RideTrack::FareDetails.new(products: products, estimates: estimates)
    end

    private

    def sort_estimates_by_price
      estimates.sort_by!{|e| e.average_estimate || 999}
    end

    def products
      @products ||= estimates.map(&:product)
    end

  end
end