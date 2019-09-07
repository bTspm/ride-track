module Storage
  class IpStore
    def get_ip_details(ip_or_domain)
      response = _client.get_details(ip_or_domain)
      _build_ip_details(response)
    end

    private

    def _build_ip_details(response)
      _validate_response(response)
      Domains::Ip::IpDetail.new(response.body)
    end

    def _client
      Api::IpClient.new
    end

    def _validate_response(response)
      unless response.success
        raise Exceptions::AppExceptions::ApiError.new(message: response.body&.dig(:error_description))
      end

      return if response.body[:status] == 'success'
      raise Exceptions::IpExceptions::InvalidQueryException.new(response.body[:query])
    end
  end
end

