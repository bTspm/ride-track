module Exceptions
  module IpExceptions

    class InvalidQueryException < StandardError
      attr_reader :query

      def initialize(query)
        @query = query
      end
    end
  end
end

