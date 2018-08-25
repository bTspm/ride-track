module Domains::RideTrack::Lyft
  class Product < Domains::RideTrack::BaseProduct

    def initialize(response:)
      raise ArgumentError.new('response is required') if response.blank?
      @response = response
    end

    def capacity
      response[:seats]
    end

    def image
      response[:image_url]
    end

    def display_name
      response[:display_name]
    end

    def shared?
      SHARED.include? display_name.downcase
    end

    def id
      response[:ride_type]
    end

    def distance_unit
      Constants::MILE
    end

    def has_price_details?
      price_details.present?
    end

    def base_price
      response[:base_charge] / 100.0
    end

    def cost_per_minute
      price_details[:cost_per_minute] / 100.0
    end

    def cost_per_distance
      price_details[:cost_per_mile] / 100.0
    end

    def cancellation_fee
      price_details[:cancel_penalty_amount] / 100.0
    end

    def minimum
      price_details[:cost_minimum] / 100.0
    end

    def currency_code
      price_details[:currency]
    end

    private

    SHARED = 'shared'.freeze

    attr_reader :response

    def price_details
      response[:pricing_details] || {}
    end

  end
end
