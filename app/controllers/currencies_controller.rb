class CurrenciesController < ApplicationController
  layout 'currencies/application'

  def home
    @exchange_rate = currency_service.get_exchange_rate_from_ip('71.232.211.223')
    @currencies    = currency_service.get_currencies
    @histories     = currency_service.get_currency_histories(
      from: @exchange_rate.from_currency.code,
      to:   @exchange_rate.to_currency.code
    )
  end

  def convert
    @currencies    = currency_service.get_currencies
    @exchange_rate = currency_service.get_exchange_rate(from: params[:from], to: params[:to])
    @histories     = currency_service.get_currency_histories(from: params[:from], to: params[:to])
  end

  def history
    @histories = currency_service.get_currency_histories(from: params[:from], to: params[:to])
    @histories_data = {
      rates: @histories.map(&:rate),
      dates: @histories.map(&:date),
      label: "#{params[:from]} to #{params[:to]}"
    }
  end
  
  def currencies_list
    @currencies = currency_service.get_currencies
  end
end

