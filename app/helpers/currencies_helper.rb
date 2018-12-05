module CurrenciesHelper
  def break_countries(countries:)
    countries.sort_by {|a| a.name}.in_groups(2, false)
  end

  def currency_select_option(country:, selected: false)
    content_tag :option,
                currency_name_with_code(currency: country.currency),
                currency_name: formatted_currency_name(currency_name: country.currency.name),
                value: country.currency.code,
                selected: selected,
                data: {icon: "flag-icon flag-icon-#{country.code}", subtext: " - #{country.name}"}
  end

  def formatted_currency_name(currency_name:)
    currency_name.split.map(&:capitalize).join(' ')
  end

  def currency_name_with_code(currency:)
    "#{formatted_currency_name(currency_name: currency.name)} (#{currency.code})"
  end
end
