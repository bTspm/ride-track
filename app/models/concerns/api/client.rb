module Api
  class Client

    def initialize(url: nil, auth_type:, auth_options: {}, adapter: Faraday.default_adapter, headers: {})
      raise ArgumentError.new('Both url and auth_type are required') if url.blank? || auth_type.blank?
      @url = url
      @auth_type = auth_type
      @auth_options = auth_options.with_indifferent_access
      @adapter = adapter
      @headers = headers.with_indifferent_access
      @conn = build_connection
    end

    def _get(url:, cache_key:, expire_time: CACHE_IN_SECONDS)
      response = Rails.cache.fetch("#{cache_key}", expires_in: expire_time) do
        conn.get url
      end
      parse_response(response: response)
    end

    def _post(url:, cache_key:, expire_time: CACHE_IN_SECONDS, body:)
      response = Rails.cache.fetch("#{cache_key}", expires_in: expire_time) do
        conn.post url, body
      end
      parse_response(response: response)
    end

    private

    CACHE_IN_SECONDS = 60

    attr_reader :conn, :url, :auth_type, :auth_options, :adapter, :headers

    def parse_response(response:)
      Api::Response.new(
          body: response.body,
          status: response.status,
          headers: response.headers,
          success: response.success?
      )
    end

    def build_connection
      Faraday.new(url: url) do |conn|

        # Headers
        conn.headers = headers
        case auth_type
        when 'Bearer', 'Token', 'Basic'
          conn.authorization auth_type, auth_options[:token]
        when 'Basic Auth'
          conn.basic_auth(auth_options[:username], auth_options[:password])
        else
          'a'
        end

        # Request
        conn.request :json

        # Response
        conn.response :json
        conn.response :logger

        conn.adapter adapter
      end
    end

  end
end