module Domains::RideTrack::Uber
  class Product < Domains::RideTrack::BaseProduct

    attr_reader :capacity, :image, :display_name, :description

    def initialize(response:)
      raise ArgumentError.new('response is required') if response.blank?
      @response = response
      @capacity = response[:capacity]
      @image = response[:image]
      @display_name = response[:display_name]
      @description = response[:description]
    end

    def description
      "#{response[:short_description]} - #{response[:description]}"
    end

    def shared?
      response[:shared]
    end

    def base_price
      response[:base]
    end

    def pay_in_cash?
      response[:cash_enabled]
    end

    def id
      response[:product_id]
    end

    def distance_unit
      price_details[:distance_unit]
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

    def has_price_details?
      price_details.present?
    end

    private

    attr_reader :response

    def price_details
      response[:price_details] || {}
    end

  end
end
