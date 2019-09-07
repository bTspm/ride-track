module Storage
  class IpQualityStore
    def get_ip_quality_details(ip)
      response = _client.get_details(ip)
      _build_ip_quality_details(response)
    end

    private

    def _build_ip_quality_details(response)
      _validate_response(response)
      Domains::Ip::QualityDetail.new(response.body)
    end

    def _client
      Api::IpQualityClient.new
    end

    def _validate_response(response)
      return if response.success
      raise Exceptions::AppExceptions::ApiError.new(message: response.body&.dig(:error_description))
    end
  end
end

