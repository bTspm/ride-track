class RideTracksController < ApplicationController

  layout 'ride_tracks/application'

  def home
  end

  def price_estimate
    @price_estimates = ride_track_service.get_price_estimates(request: build_request)
  rescue Exceptions::RideTrack::InvalidParameters => e
    @error = e.message
  end

  private

  def estimate_origin_params
    params.require(:origin_details).permit ESTIMATE_PARAMS_LIST
  end

  def estimate_destination_params
    params.require(:destination_details).permit ESTIMATE_PARAMS_LIST
  end

  ESTIMATE_PARAMS_LIST = [:latitude, :longitude, :city, :state, :postal_code, :country]

  def build_request
    Domains::RideTrack::PriceEstimateRequest.new(
        origin_details: estimate_origin_params,
        destination_details: estimate_destination_params
    )
  end
end
