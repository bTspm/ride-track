module Domains::RideTrack::Lyft
  class PriceEstimate < Domains::RideTrack::BasePriceEstimate

    attr_reader :product

    def initialize(response:)
      raise ArgumentError.new('response and provider are required') if response.blank?
      @response = response
    end

    def provider
      Constants::LYFT
    end

    def display_name
      response[:display_name]
    end

    def distance
      response[:estimated_distance_miles]
    end

    def duration
      response[:estimated_duration_seconds]
    end

    def product_id
      response[:ride_type]
    end

    def local_name
      response[:display_name]
    end

    def surge_value
      response[:primetime_percentage].to_i || 0
    end

    def duration_in_minutes
      return 0 if duration.blank?
      duration / 60
    end
    
    def surge?
      surge_value > 1
    end

    def high_estimate
      response[:estimated_cost_cents_max] / 100
    end

    def low_estimate
      response[:estimated_cost_cents_min] / 100
    end

    def currency_code
      response[:currency]
    end

    def add_product(product:)
      @product = product
    end

    private

    attr_reader :response

  end
end