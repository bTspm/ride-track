module Domains::RideTrack
  class Filters

    def initialize(products:)
      @products = products
    end

    def capacities
      filter_with_frequency(array: products.map(&:capacity))
    end

    def providers
      filter_with_frequency(array: products.map(&:provider))
    end

    def features
      features = {}
      features[:shared] = products.select {|p| p.shared?}.size
      features[:pay_cash] = products.select {|p| p.pay_in_cash?}.size
      features[:no_cancellation] = products.select {|p| p.cancellation_fee.nil? || p.cancellation_fee == 0}.size
      features.delete_if { |key, value| value < 1 }.with_indifferent_access
    end

    private

    attr_reader :products

    def filter_with_frequency(array:)
      return {} if array.blank?
      array.each_with_object(Hash.new(0)) {|key, hash| hash[key] += 1}
    end

  end
end