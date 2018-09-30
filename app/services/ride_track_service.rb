module Services
  class RideTrackService < BusinessService
    include Services

    def get_price_estimates(request:)
      @estimate_builder = Domains::RideTrack::PriceEstimateBuilder.new(request: request)
      price_estimates(store: uber_storage)
      price_estimates(store: lyft_storage)
      estimate_builder.build
      estimate_builder
    end

    private

    attr_reader :estimate_builder

    def price_estimates(store:)
      estimate_builder.products += store.get_products(request: estimate_builder.request.origin)
      estimate_builder.estimates += store.get_price_estimates(request: estimate_builder.request)
    rescue Exceptions::RideTrack::ApiError, Exception => e
      estimate_builder.errors << e.message
    end

  end
end