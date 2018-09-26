module Exceptions
  module RideTrack

    class ApiError < StandardError
      attr_reader :message

      def initialize(message:)
        @message = message
      end
    end

    class NoSelectionError < StandardError
      attr_reader :selection

      def initialize(selection:)
        @selection = selection
      end
    end

  end
end