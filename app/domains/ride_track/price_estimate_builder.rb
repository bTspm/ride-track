module Domains::RideTrack
  class PriceEstimateBuilder

    attr_reader :request
    attr_accessor :estimates, :errors, :products

    def initialize(request:)
      raise ArgumentError.new('request is required') if request.blank?
      @request = request
      @estimates = []
      @products = []
      @errors = []
    end

    def build
      return if estimates.blank?
      assign_products_to_estimates
      sort_estimates_by_price
    end

    def filters
      Domains::RideTrack::Filters.new(products: products)
    end

    def fare_details
      Domains::RideTrack::FareDetails.new(products: products, estimates: estimates)
    end

    private

    def sort_estimates_by_price
      estimates.sort_by!{|e| e.average_estimate || 999}
    end

    def assign_products_to_estimates
      products_hash = products.map { |u| [u.id, u] }.to_h
      estimates.map{|e| e.product = products_hash[e.product_id]}
    end

  end
end