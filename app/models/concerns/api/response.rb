module Api

  class Response

    attr_reader :status, :headers, :success

    def initialize(body:, status:, headers:, success:)
      @response_body = body
      @status = status
      @headers = headers
      @success = success
    end

    def body
      JSON.parse(response_body).with_indifferent_access
    end

    private

    attr_reader :response_body

  end

end