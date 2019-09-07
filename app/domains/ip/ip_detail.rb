module Domains::Ip
  class IpDetail
    attr_reader :address,
                :as,
                :as_name,
                :hostname,
                :isp,
                :ip,
                :mobile,
                :organization,
                :timezone

    def initialize(response = {})
      @response = (response || {}).with_indifferent_access
      @address = build_address
      @as = response[:as]
      @as_name = response[:asname]
      @hostname = response[:reverse]&.presence || response[:query]
      @isp = response[:isp]
      @ip = response[:query]
      @mobile = response[:mobile]
      @organization = response[:org]
      @timezone = response[:timezone]
    end

    private

    def build_address
      return if @response.blank?
      address_details = {
        latitude: @response[:lat],
        longitude: @response[:lon],
        city: @response[:city],
        state_code: @response[:region],
        state_name: @response[:regionName],
        country_code: @response[:countryCode],
        country_name: @response[:country],
        currency_code: @response[:currency],
        time_zone: @response[:timezone],
        zip_code: @response[:zip]
      }
      ::Domains::Address.new(details: address_details)
    end
  end
end

