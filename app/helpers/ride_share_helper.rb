module RideShareHelper

  def distance_with_units(distance:, unit:)
    return '' if distance.blank? || unit.blank?
    "approx ~ #{distance} #{unit.classify.pluralize}"
  end

  def avg_cost_with_currency_code

  end

  def categories(product:)
    categories = ''
    categories += "#{product.capacity}"
    categories += " #{product.provider}"
    categories += ' cash' if product.pay_in_cash?
    categories += ' shared' if product.shared?
    if product.cancellation_fee.nil? || product.cancellation_fee == 0
      categories += ' no_cancellation'
    end
    categories
  end

end