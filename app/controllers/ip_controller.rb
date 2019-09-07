class IpController < ApplicationController
  layout 'ip/application'

  def home
    redirect_to action: :ip_search, ip_input: request.ip
  end

  def ip_search
    @ip_detail = present(_ip_details, Presenters::IpDetails::IpDetailsPresenter)
    @quality_detail = present(_ip_quality_details, Presenters::IpDetails::IpQualityPresenter)
  rescue Exceptions::IpExceptions::InvalidQueryException => e
    render 'ip/ip_error_page', status: 400, locals: { query: e.query }
  rescue Exception => e
    render template: 'ip/general_error', status: 500, locals: { error_message: e.to_s, client_ip: request.ip }
  end

  private

  def _ip_details
    ip_service.get_ip_details(params[:ip_input])
  end

  def _ip_quality_details
    ip_service.get_ip_quality_details(@ip_detail.ip)
  end
end

