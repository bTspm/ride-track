module Domains
  class Address

    attr_reader :latitude,
                :longitude,
                :city,
                :state_code,
                :state_name,
                :country_code,
                :country_name,
                :zip_code

    def initialize(details:)
      @latitude     = details[:latitude]
      @longitude    = details[:longitude]
      @city         = details[:city]
      @state_code   = details[:state_code]
      @state_name   = details[:state_name]
      @country_code = details[:country_code]
      @country_name = details[:country_name]
      @zip_code     = details[:zip_code]
    end

    def is_us?
      country_code.downcase == 'us' || country_code.downcase == 'usa'
    end
  end
end

