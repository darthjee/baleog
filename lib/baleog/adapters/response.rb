# frozen_string_literal: true

module Baleog
  module Adapters
    # @api public
    # @author darthjee
    #
    # Response returned from an Adapter
    #
    # Adapters that have different response objects
    # may implement a custom {Adapters::Response} class
    # to have a common interface
    class Response
      # @param original_response [Object] Response from the connector
      def initialize(original_response)
        @original_response = original_response
      end

      # @method body
      # @api public
      #
      # Returns original response body
      #
      # @return [String]

      # @method status
      # @api public
      #
      # Returns original response HTTP status code
      #
      # @return [Integer]
      delegate :body, :status, to: :original_response

      private

      # @method original_response
      # @api public
      # @private
      #
      # Original response from the connector
      #
      # @return [Integer]
      attr_reader :original_response
    end
  end
end
