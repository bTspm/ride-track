module Domains
  class Address

    attr_reader :latitude, :longitude

    def initialize(details:)
      @latitude = details[:latitude]
      @longitude = details[:longitude]
    end

  end
end