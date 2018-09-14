module Domains::RideTrack::Uber
  class PriceEstimate < Domains::RideTrack::BasePriceEstimate

    attr_reader :display_name, :distance, :duration, :currency_code, :product_id

    def initialize(response:)
      raise ArgumentError.new('response is required') if response.blank?
      @response = response
      @display_name = response[:display_name]
      @distance = response[:distance]
      @duration = response[:duration]
      @currency_code = response[:currency_code]
      @product_id = response[:product_id]
    end

    def provider
      Constants::UBER
    end

    def high_estimate
      response[:high_estimate].presence || 0
    end

    def low_estimate
      response[:low_estimate].presence || 0
    end

    def surge_value
      response[:surge_multiplier].presence || 0
    end

    private

    attr_reader :response

  end
end