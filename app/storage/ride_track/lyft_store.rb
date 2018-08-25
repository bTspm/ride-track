module Storage::RideTrack
  class LyftStore

    def get_price_estimates(request:)
      raise ArgumentError.new('request is required') if request.blank?

      response = client.get_price_estimates(
          start_latitude: request.origin.latitude,
          start_longitude: request.origin.longitude,
          end_latitude: request.destination.latitude,
          end_longitude: request.destination.longitude
      )
      validate_response(response: response)
      build_price_estimates(response: response)
    end

    def get_products(request:)
      raise ArgumentError.new('request is required') if request.blank?

      response = client.get_products(
          latitude: request.latitude,
          longitude: request.longitude,
          )
      validate_response(response: response)
      build_products(response: response)
    end

    private

    def client
      Api::LyftClient.new
    end

    def validate_response(response:)
      return if response.success
      raise Exceptions::RideTrack::ApiError.new(message: response.body[:error_description])
    end

    def build_price_estimates(response:)
      response.body[:cost_estimates].map { |price|
        Domains::RideTrack::Lyft::PriceEstimate.new(response: price)
      }
    end

    def build_products(response:)
      response.body[:ride_types].map { |product|
        Domains::RideTrack::Lyft::Product.new(response: product)
      }
    end

  end
end