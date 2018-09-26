module Domains::RideTrack::Uber
  class PriceEstimate < Domains::RideTrack::BasePriceEstimate

    def initialize(response:)
      raise ArgumentError.new('response is required') if response.blank?
      @response = response
    end

    def provider
      Constants::UBER
    end

    def distance_unit
      Constants::MILE
    end

    def display_name
      response[:display_name]
    end

    def distance
      response[:distance]
    end

    def duration
      response[:duration]
    end

    def duration_in_minutes
      duration.blank? ? 0 : duration / 60
    end

    def product_id
      response[:product_id]
    end

    def currency_code
      response[:currency_code]
    end

    def surge_value
      response[:surge_multiplier].presence || 0
    end

    def high_estimate
      response[:high_estimate].presence || 0
    end

    def low_estimate
      response[:low_estimate].presence || 0
    end

    private

    attr_reader :response

  end
end