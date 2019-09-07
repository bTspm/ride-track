module Domains
  class Address

    US_COUNTRY_CODES = %w(us usa)

    attr_reader :latitude,
                :longitude,
                :city,
                :state_code,
                :state_name,
                :country_code,
                :country_name,
                :currency_code,
                :time_zone,
                :zip_code

    def initialize(details:)
      @latitude = details[:latitude]
      @longitude = details[:longitude]
      @city = details[:city]
      @state_code = details[:state_code]
      @state_name = details[:state_name]
      @country_code = details[:country_code]
      @country_name = details[:country_name]
      @currency_code = details[:currency_code]
      @time_zone = details[:time_zone]
      @zip_code = details[:zip_code]
    end

    def is_us?
      return false if country_code.blank?
      US_COUNTRY_CODES.include? country_code.downcase
    end
  end
end

