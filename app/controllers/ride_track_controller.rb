class RideTrackController < ApplicationController

  def home_page
  end

  def price_estimate
    @price_estimates = Services::RideTrackService.new.get_price_estimates(
        origin_details: estimate_origin_params,
        destination_details: estimate_destination_params
    )
  end

  private

  def estimate_origin_params
    params.require(:origin_details).permit ESTIMATE_PARAMS_LIST
  end

  def estimate_destination_params
    params.require(:destination_details).permit ESTIMATE_PARAMS_LIST
  end

  ESTIMATE_PARAMS_LIST = [:latitude, :longitude, :city, :state, :postal_code, :country]

end