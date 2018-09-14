module Domains::RideTrack
  class BasePriceEstimate

    attr_reader :product

    def average_estimate
      calc_estimates
    end

    def high_estimate
      raise NotImplementedError
    end

    def low_estimate
      raise NotImplementedError
    end

    def surge?
      surge_value > 1
    end

    def surge_value
      raise NotImplementedError
    end

    def product=(product)
      @product = product
    end

    def duration_in_minutes
      duration.blank? ? 0 : duration / 60
    end

    def duration
      raise NotImplementedError
    end

    private

    def valid_estimates?
      high_estimate > 0 && low_estimate > 0
    end

    def calc_estimates
      valid_estimates? ? (high_estimate + low_estimate) / 2 : nil
    end

  end
end