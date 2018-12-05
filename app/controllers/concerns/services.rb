module Services
  extend ActiveSupport::Concern
  included do

    def ride_track_service
      @ride_track_service ||= Services::RideTrackService.new
    end

    def currency_service
      @currency_service ||= Services::CurrencyService.new
    end
  end
end