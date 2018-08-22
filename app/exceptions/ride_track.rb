module Exceptions
  module RideTrack

    class ApiError < StandardError
      attr_reader :message

      def initialize(message:)
        @message = message
      end
    end

  end
end