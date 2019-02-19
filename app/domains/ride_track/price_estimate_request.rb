module Domains::RideTrack
  class PriceEstimateRequest
    attr_reader :origin, :destination

    def initialize(origin_details:, destination_details:)
      @origin_details = origin_details
      @destination_details = destination_details
      validate_attrs
      @origin = Domains::Address.new(details: origin_details)
      @destination = Domains::Address.new(details: destination_details)
    end

    private

    def validate_attrs
      error = if !origin_valid? && !destination_valid?
                'Error! please enter valid origin and destination address.'
              elsif !origin_valid?
                'Error! please enter valid origin address.'
              elsif !destination_valid?
                'Error! please enter valid destination address.'
              else
                nil
              end
      return if error.blank?
      raise Exceptions::AppExceptions::InvalidParameters.new(message: error)
    end

    def origin_valid?
      @origin_validity ||= @origin_details.values_at(:latitude, :longitude).all?
    end

    def destination_valid?
      @destination_validity ||= @destination_details.values_at(:latitude, :longitude).all?
    end
  end
end
