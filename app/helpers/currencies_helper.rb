module CurrenciesHelper
  def currency_select_option(currency:, selected:)
    content_tag :option,
                currency_name_with_code(currency: currency),
                currency_name: formatted_currency_name(currency_name: currency.name),
                value: currency.code,
                selected: selected,
                data: {icon: "currency-flag currency-flag-#{(currency.code).try(:downcase)}"}
  end

  def formatted_currency_name(currency_name:)
    currency_name.split.map(&:capitalize).join(' ')
  end

  def currency_name_with_code(currency:)
    "#{formatted_currency_name(currency_name: currency.name)} (#{currency.code})"
  end
end

