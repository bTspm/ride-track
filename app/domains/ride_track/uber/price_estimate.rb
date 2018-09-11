module Domains::RideTrack::Uber
  class PriceEstimate < Domains::RideTrack::BasePriceEstimate

    attr_reader :display_name, :distance, :duration, :currency_code,
                :high_estimate, :low_estimate, :product_id

    def initialize(response:)
      raise ArgumentError.new('response is required') if response.blank?
      @response = response
      @display_name = response[:display_name]
      @distance = response[:distance]
      @duration = response[:duration]
      @currency_code = response[:currency_code]
      @high_estimate = response[:high_estimate]
      @low_estimate = response[:low_estimate]
      @product_id = response[:product_id]
    end

    def provider
      Constants::UBER
    end

    def surge_value
      response[:surge_multiplier].presence || 0
    end

    def duration_in_minutes
      return 0 if duration.blank?
      duration / 60
    end
    
    def surge?
      surge_value > 1
    end

    private

    attr_reader :response

  end
end