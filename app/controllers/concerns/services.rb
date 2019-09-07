module Services
  extend ActiveSupport::Concern
  included do
    def currency_service
      @currency_service ||= Services::CurrencyService.new
    end

    def ip_service
      @ip_service ||= Services::IpService.new
    end

    def ride_track_service
      @ride_track_service ||= Services::RideTrackService.new
    end
  end
end