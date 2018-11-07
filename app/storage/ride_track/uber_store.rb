module Storage::RideTrack
  class UberStore

    def get_price_estimates(request:)
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
      response = client.get_products(
          latitude: request.latitude,
          longitude: request.longitude,
      )
      validate_response(response: response)
      build_products(response: response)
    end

    private

    def client
      Api::UberClient.new
    end

    def validate_response(response:)
      return if response.success
      raise Exceptions::RideTrack::ApiError.new(message: response.body[:message])
    end

    def build_price_estimates(response:)
      response.body[:prices].map { |price|
        Domains::RideTrack::Uber::PriceEstimate.new(response: price)
      }
    end

    def build_products(response:)
      response.body[:products].map { |product|
        Domains::RideTrack::Uber::Product.new(response: product)
      }
    end

  end
end