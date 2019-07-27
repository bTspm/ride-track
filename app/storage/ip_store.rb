module Storage
  class IpStore
    def get_ip_details(ip)
      response = client.get_details(ip)
      build_ip_details(response)
    end

    private

    def build_ip_details(response)
      validate_response(response)
      Domains::IpDetail.new(response.body)
    end

    def client
      Api::IpClient.new
    end

    def validate_response(response)
      return if response.success
      raise Exceptions::AppExceptions::ApiError.new(message: response.body&.dig(:error_description))
    end
  end
end

