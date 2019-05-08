module Api
  class Response

    attr_reader :status, :headers, :success, :body

    def initialize(body:, status:, headers:, success:)
      @body = body.try(:with_indifferent_access)
      @status = status
      @headers = headers
      @success = success
    end

  end
end