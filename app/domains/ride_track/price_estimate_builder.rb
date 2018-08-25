module RideTrack
  class PriceEstimateBuilder

    attr_reader :request, :minimum_duration_in_minutes, :minimum_distance, :distance_unit
    attr_accessor :estimates, :errors

    def initialize(request:)
      raise ArgumentError.new('request is required') if request.blank?
      @request = request
      @estimates = []
      @errors = []
    end

    def build
      return if estimates.blank?
      get_products
      sort_estimates_by_price
      filter_options
      self
    end

    private

    attr_reader :products

    def sort_estimates_by_price
      estimates.sort_by!{|e| e.average_estimate}
    end

    def filter_options
      @capacities = products.map(&:capacity).uniq.sort
      @distance_unit = products.map(&:distance_unit).first
      @providers = estimates.map(&:provider).uniq.sort
      @minimum_distance = estimates.map(&:distance).min
      @minimum_duration_in_minutes = estimates.map(&:duration_in_minutes).min
    end

    def get_products
      @products = estimates.map(&:product)
    end

  end
end