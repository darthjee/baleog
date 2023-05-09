# frozen_string_literal: true

module Baleog
  class Client
    # @api public
    # @author darthjee
    #
    # Class representing a response from the API
    #
    # This classes wraps the response from the HTTP request
    # library used by the connector
    class Response < Sinclair::Model
      initialize_with(:response, :request)

      # @method initialize(response:, request:)
      # @api private
      #
      # @param response [Adapters::Response] Response from the adapter
      # @param request [Client::Request] Original request

      # @method response
      # @api public
      #
      # Returns the response from the adapter
      #
      # @return [Adapters::Response]

      # @method request
      # @api public
      #
      # Returns the original request
      #
      # @return [Client::Request]

      # Returns JSON parsed response body
      #
      # @return [Hash]
      def parsed_body
        @parsed_body ||= JSON.parse(body)
      end

      # Returns the Model representation of the response body
      #
      # @return [Hash] Parsed body when model has not been defined
      # @return [Baleog::Model] Model representation when model has been defined
      def object
        return parsed_body unless model

        model.from(parsed_body)
      end

      # @method status
      # @api public
      #
      # Returns the HTTP response status
      #
      # @see Adapters::Response#status
      # @return [Integer]

      # @method body
      # @api public
      #
      # Returns the HTTP response body
      #
      # @see Adapters::Response#body
      # @return [String]
      delegate :status, :body, to: :response

      # @method model
      # @api public
      #
      # Returns the Baelog model class
      #
      # @see Baleog::Endpoint#model
      # @return [Baleog::Model]
      delegate :model, to: :request
    end
  end
end
