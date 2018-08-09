class RideTrackController < ApplicationController

  def home_page
  end


  def estimate

  end

  private

  def estimate_origin_params
    params.require(:origin_details).permit ESTIMATE_PARAMS_LIST
  end

  def estimate_destination_params
    params.require(:destination_details).permit ESTIMATE_PARAMS_LIST
  end

  ESTIMATE_PARAMS_LIST = [:latitude, :longitude, :locality, :state, :postal_code, :country]

end