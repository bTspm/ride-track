module Domains::RideTrack
  class BasePriceEstimate

    attr_reader :product

    def average_estimate
      return '' if high_estimate.blank? || low_estimate.blank?
      (high_estimate + low_estimate) / 2
    end

    def high_estimate
      raise NotImplementedError
    end

    def low_estimate
      raise NotImplementedError
    end

    def provider
      raise NotImplementedError
    end

    def currency_code
      raise NotImplementedError
    end

    def product=(product)
      @product = product
    end

  end
end