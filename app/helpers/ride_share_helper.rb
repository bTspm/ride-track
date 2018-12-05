module RideShareHelper

  def distance_with_units(distance:, unit:)
    return '' if distance.blank? || unit.blank?
    "approx ~ #{distance} #{unit.classify.pluralize}"
  end

  def minimum_distance(duration:)
    return '' if duration.blank?
    text = "approx ~"
    return "#{text} #{duration} min" if duration < 60
    hours = duration / 60
    minutes = (duration) % 60
    "#{text} #{ hours }hr #{ minutes }min"
  end

  def cost_with_currency(cost:, currency:)
    content_tag :h4, "#{cost}  #{currency}"
  end

  def categories(product:)
    categories = "#{product.capacity}"
    categories += " #{product.provider}"
    categories += ' cash' if product.pay_in_cash?
    categories += ' shared' if product.shared?
    if product.cancellation_fee.nil? || product.cancellation_fee == 0
      categories += ' no_cancellation'
    end
    categories
  end

end