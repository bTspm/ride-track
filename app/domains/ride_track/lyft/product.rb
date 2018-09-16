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
      response[:display_name] || ''
    end

    def shared?
      display_name.downcase.include? 'shared'
    end

    def id
      response[:ride_type]
    end

    def distance_unit
      Constants::MILE if has_price_details?
    end

    def has_price_details?
      price_details.present?
    end

    def base_price
      calc_price(value: price_details[:base_charge])
    end

    def cost_per_minute
      calc_price(value: price_details[:cost_per_minute])
    end

    def cost_per_distance
      calc_price(value: price_details[:cost_per_mile])
    end

    def cancellation_fee
      calc_price(value: price_details[:cancel_penalty_amount])
    end

    def minimum
      calc_price(value: price_details[:cost_minimum])
    end

    def currency_code
      price_details[:currency]
    end

    private

    attr_reader :response

    def price_details
      response[:pricing_details] || {}
    end

    def calc_price(value:)
      value.blank? ? nil  : value / 100.00
    end

  end
end
