module Domains
  class IpDetail
    attr_reader :address,
                :as,
                :ip,
                :isp,
                :organization,
                :timezone

    def initialize(response = {})
      @response     = response
      @address      = build_address
      @as           = response[:as]
      @isp          = response[:isp]
      @organization = response[:org]
      @ip           = response[:query]
      @timezone     = response[:timezone]
    end

    private

    def build_address
      return if @response.blank?
      address_details = {
        latitude:     @response[:lat],
        longitude:    @response[:lon],
        city:         @response[:city],
        state_code:   @response[:region],
        state_name:   @response[:regionName],
        country_code: @response[:countryCode],
        country_name: @response[:country],
        zip_code:     @response[:zip]
      }
      Address.new(details: address_details)
    end
  end
end

