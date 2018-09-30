module Services
  extend ActiveSupport::Concern
  included do

    def ride_track_service
      @ride_track_service ||= Services::RideTrackService.new
    end

  end
end