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

    def distance_in_unit
      return distance if product_distance_unit == distance_unit
      (convert_distance).round(2)
    end

    def distance
      raise NotImplementedError
    end

    def distance_unit
      raise NotImplementedError
    end

    private

    def product_distance_unit
      product.try(:distance_unit)
    end

    def valid_estimates?
      high_estimate > 0 && low_estimate > 0
    end

    def calc_estimates
      valid_estimates? ? (high_estimate + low_estimate) / 2 : nil
    end

    def convert_distance
      if distance_unit == Constants::MILE
        distance * 1.6
      elsif distance_unit == Constants::KM
        distance * 0.6
      else
        raise Exceptions::AppExceptions::NoSelectionError.new(selection: distance_unit)
      end
    end

  end
end