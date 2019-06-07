class CurrenciesController < ApplicationController
  layout 'currencies/application'

  def home
    # @currencies = currency_service.get_currencies_from_ip(request.ip)
    @currencies = currency_service.get_currencies_from_ip(request.ip)
    redirect_to action: :convert, from: @currencies[:from], to: @currencies[:to]
  end

  def convert
    @currencies         = present(currency_service.get_currencies, ::Presenters::Currency::CurrenciesPresenter)
    @exchange_rate      = present(_exchange_rate, ::Presenters::Currency::ExchangeRatePresenter)
    @history_response   = present(_history_response, ::Presenters::Currency::HistoryResponsePresenter)
    @popular_currencies = present(_popular_currencies, ::Presenters::Currency::ExchangeRatePresenter)
  end

  def list
    @currencies = present(currency_service.get_currencies, ::Presenters::Currency::CurrenciesPresenter)
  end

  private

  def _exchange_rate
    currency_service.get_exchange_rate_with_currency_details(from: params[:from], to: params[:to])
  end

  def _history_response
    currency_service.get_currency_histories(from: params[:from], to: params[:to])
  end

  def _popular_currencies
    currency_service.get_popular_currency_exchanges(params[:from])
  end
end

