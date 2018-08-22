module Services
  class RideTrackService < BusinessService
    include Services

    def get_price_estimates(origin_details:, destination_details:)
      price_estimate_request = Domains::RideTrack::PriceEstimateRequest.new(
          origin_details: origin_details,
          destination_details: destination_details
      )
      @estimate_builder = RideTrack::PriceEstimateBuilder.new(request: price_estimate_request)
      get_uber_price_estimates
      estimate_builder.build
    end

    private

    attr_reader :estimate_builder

    def get_uber_price_estimates
      products = uber_storage.get_products(request: estimate_builder.request.origin).map { |u| [u.id, u] }.to_h
      price_estimates = uber_storage.get_price_estimates(request: estimate_builder.request)
      price_estimates.map{|pe| pe.add_product(product: products[pe.product_id])}
      estimate_builder.estimates += price_estimates
    rescue Exceptions::RideTrack::ApiError => e
      estimate_builder.errors << e.message
    end

  end
end