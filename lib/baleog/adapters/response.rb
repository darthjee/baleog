# frozen_string_literal: true

module Baleog
  module Adapters
    class Response
      def initialize(original_response)
        @original_response = original_response
      end

      delegate :body, :status, to: :original_response

      private

      attr_reader :original_response
    end
  end
end
