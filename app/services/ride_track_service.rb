module Services
  class RideTrackService < BusinessService
    include Services

    def get_price_estimates(origin_details:, destination_details:)
      price_estimate_request = Domains::RideTrack::PriceEstimateRequest.new(
          origin_details: origin_details,
          destination_details: destination_details
      )
      @estimate_builder = RideTrack::PriceEstimateBuilder.new(request: price_estimate_request)
      price_estimates(store: uber_storage)
      price_estimates(store: lyft_storage)
      estimate_builder.build
      estimate_builder
    end

    private

    attr_reader :estimate_builder

    def price_estimates(store:)
      products = store.get_products(request: estimate_builder.request.origin).map { |u| [u.id, u] }.to_h
      price_estimates = store.get_price_estimates(request: estimate_builder.request)
      price_estimates.map{|pe| pe.product = products[pe.product_id]}
      estimate_builder.estimates += price_estimates
    rescue Exceptions::RideTrack::ApiError => e
      estimate_builder.errors << e.message
    rescue Exception => e
      estimate_builder.errors << e.message
    end

  end
end