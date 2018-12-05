class CurrenciesController < ApplicationController
  layout 'currencies/application'

  def home
    @countries = currency_service.get_countries_with_currencies
  end

  def convert
    convert = currency_service.get_exchange_rate(
        to_currency_code: params[:to_currency_code],
        from_currency_code: params[:from_currency_code]
    )
    render json: convert.to_json
  end

  def history
    history = currency_service.get_history(request: history_request)
    render json: history.to_json
  end

  def history_request
    Domains::Currency::HistoryRequest.new(
        to_currency_code: params[:to_currency_code],
        from_currency_code: params[:from_currency_code]
    )
  end
end
