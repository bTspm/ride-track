module Api
  class Client

    def initialize(url:, auth_type:, auth_options:, headers: {})
      if url.blank? || auth_type.blank? || auth_options.blank?
        raise ArgumentError.new('auth_options, url and auth_type are required')
      end

      @url = url
      @auth_type = auth_type
      @auth_options = auth_options.with_indifferent_access
      @headers = headers.with_indifferent_access
      @conn = build_connection
    end

    def _get(url:, cache_key:, expire_time: CACHE_IN_SECONDS)
      response = Rails.cache.fetch("#{cache_key}", expires_in: expire_time) do
        conn.get url
      end
      parse_response(response: response)
    end

    def _post(url:, cache_key:, expire_time: CACHE_IN_SECONDS, request:)
      response = Rails.cache.fetch("#{cache_key}", expires_in: expire_time) do
        conn.post url, request
      end
      parse_response(response: response)
    end

    private

    #auth types
    BEARER = 'Bearer'.freeze
    TOKEN = 'Token'.freeze
    BASIC = 'Basic'.freeze
    BASIC_AUTH = 'Basic Auth'.freeze
    AUTHORIZATION = [BEARER, TOKEN, BASIC]

    CACHE_IN_SECONDS = 60

    attr_reader :conn, :url, :auth_type, :auth_options, :headers

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
        when *AUTHORIZATION
          conn.authorization auth_type, auth_options[:token]
        when BASIC_AUTH
          conn.basic_auth auth_options[:username], auth_options[:password]
        else
          raise Exceptions::RideTrack::NoSelectionError.new(selection: auth_type)
        end

        # Request
        conn.request :json

        # Response
        conn.response :json
        conn.response :logger

        conn.adapter Faraday.default_adapter
      end
    end

  end
end