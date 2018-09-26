module Domains::RideTrack::Lyft
  class PriceEstimate < Domains::RideTrack::BasePriceEstimate

    def initialize(response:)
      raise ArgumentError.new('response is required') if response.blank?
      @response = response
    end

    def provider
      Constants::LYFT
    end

    def distance_unit
      Constants::MILE
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

    def duration_in_minutes
      duration.blank? ? 0 : duration / 60
    end

    def product_id
      response[:ride_type]
    end

    def currency_code
      response[:currency]
    end

    def surge_value
      calc_surge_value
    end

    def high_estimate
      calc_estimate(value: response[:estimated_cost_cents_max].presence)
    end

    def low_estimate
      calc_estimate(value: response[:estimated_cost_cents_min].presence)
    end

    private

    attr_reader :response

    def calc_surge_value
      value = (response[:primetime_percentage].to_i || 0)
      value == 0 ? value : (value / 100.00) + 1
    end

    def calc_estimate(value:)
      value ? value / 100 : 0
    end

  end
end