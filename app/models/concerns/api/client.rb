module Api

  class Client

    def initialize
      @conn = Faraday.new
    end

    def _get(url:, cache_key:, expire_time: CACHE_IN_SECONDS)
      response = Rails.cache.fetch("#{cache_key}", expires_in: expire_time) do
        conn.get url
      end
      parse_response(response: response)
    end

    private

    CACHE_IN_SECONDS = 60

    attr_reader :conn

    def parse_response(response:)
      Api::Response.new(
          body: response.body,
          status: response.status,
          headers: response.headers,
          success: response.success?
      )
    end

  end

end