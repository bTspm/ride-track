module CurrenciesHelper
  def currency_select_option(currency:, selected:)
    content_tag :option,
                currency.name_with_code,
                currency_name: currency.formatted_name,
                value: currency.code,
                selected: selected,
                data: {icon: "currency-flag currency-flag-#{currency.code_downcase}"}
  end
end

