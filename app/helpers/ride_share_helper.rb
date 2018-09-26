module RideShareHelper

  def distance_with_units(distance:, unit:)
    return '' if distance.blank? || unit.blank?
    "approx ~ #{distance} #{unit.classify.pluralize}"
  end

  def avg_cost_with_currency_code

  end

  def categories(price_estimate:)
    categories = ''
    categories += "#{price_estimate.product.capacity} "
    categories += "#{price_estimate.provider} "
    categories += 'cash ' if price_estimate.product.pay_in_cash?
    categories += 'shared ' if price_estimate.product.shared?
    if price_estimate.product.cancellation_fee.nil? || price_estimate.product.cancellation_fee == 0
      categories += 'no_cancellation'
    end
    categories
  end

end