module Domains::RideTrack::Uber
  class Product < Domains::RideTrack::BaseProduct

    def initialize(response:)
      @response = response
    end

    def provider
      Constants::UBER
    end

    def capacity
      response[:capacity]
    end

    def image
      response[:image]
    end

    def display_name
      response[:display_name]
    end

    def shared?
      response[:shared]
    end

    def id
      response[:product_id]
    end

    def pay_in_cash?
      response[:cash_enabled]
    end

    def distance_unit
      price_details[:distance_unit]
    end

    def has_price_details?
      price_details.present?
    end

    def base_price
      price_details[:base]
    end
    
    def cost_per_minute
      price_details[:cost_per_minute]
    end

    def cost_per_distance
      price_details[:cost_per_distance]
    end

    def cancellation_fee
      price_details[:cancellation_fee]
    end

    def minimum
      price_details[:minimum]
    end

    def currency_code
      price_details[:currency_code]
    end

    private

    attr_reader :response

    def price_details
      response[:price_details] || {}
    end

  end
end
