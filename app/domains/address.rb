module Domains
  class Address

    attr_reader :latitude, :longitude

    def initialize(details:)
      raise ArgumentError.new('details are required') if details.blank?
      @latitude = details[:latitude]
      @longitude = details[:longitude]
    end

  end
end