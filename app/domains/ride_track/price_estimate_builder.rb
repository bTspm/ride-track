module Domains::RideTrack
  class PriceEstimateBuilder

    attr_reader :request
    attr_accessor :estimates, :errors, :products, :filters, :fare_details

    def initialize(request:)
      @request = request
      @estimates = []
      @products = []
      @errors = []
    end

    def build
      if estimates.blank?
        add_no_ride_error
        return
      end
      assign_products_to_estimates
      sort_estimates_by_price
      @filters = build_filters
      @fare_details = build_fare_details
    end

    private

    def sort_estimates_by_price
      estimates.sort_by!{|e| e.average_estimate || 999}
    end

    def assign_products_to_estimates
      products_hash = products.map { |u| [u.id, u] }.to_h
      estimates.map{|e| e.product = products_hash[e.product_id]}
    end

    def add_no_ride_error
      errors << 'Error! No ride found at this moment for your destination!'
    end

    def build_filters
      return if products.blank?
      Domains::RideTrack::Filters.new(products: products)
    end

    def build_fare_details
      return if estimates.blank? || products.blank?
      Domains::RideTrack::FareDetails.new(products: products, estimates: estimates)
    end

  end
end
