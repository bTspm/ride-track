module Presenters
  class AddressesPresenter
    include Btspm::Presenters::Presentable

    class Scalar < Btspm::Presenters::ScalarPresenter

      def coordinates
        "#{latitude}, #{longitude}"
      end

      def local_time
        time = Time.now.in_time_zone(time_zone)
        time.strftime("#{time.day.ordinalize} %b %y, %I:%M %p")
      end

      def location
        return city if zip_code.blank?
        "#{zip_code}, #{city}"
      end

      def map_location_params
        {
          coordinates: _map_coordinates,
          selector: _map_selector,
          title: _map_title
        }.to_json
      end

      private

      def _map_coordinates
        { lat: latitude, lng: longitude }
      end

      def _map_selector
        'ip-location-map-container'
      end

      def _map_title
        "#{city}, #{state_code}, #{country_code}"
      end
    end
  end
end

