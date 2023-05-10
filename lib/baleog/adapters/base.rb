# frozen_string_literal: true

module Baleog
  module Adapters
    # @api public
    # @author darthjee
    # @abstract
    #
    # Base interface / implementation of Adapters
    class Base < Sinclair::Model
      initialize_with(:request)

      # @method initialize(request:)
      # @api public
      #
      # @param request [Client::Request]

      # Makes an HTTP request against an enndpoint
      #
      # @param request [Client::Request]
      #
      # @return [Adapters::Response]
      def self.call(request)
        new(request: request).call
      end

      # Makes an HTTP request against an enndpoint
      #
      # @raise [NotImplementedError] The method needs to be
      #   implemented in the child adapter
      #
      # @return [Adapters::Response]
      def call
        raise NotImplementedError,
              'This needs to be implemented in the child class'
      end

      # @method url
      # @api public
      #
      # Complete URL of the request
      #
      # @see Client::Endpoint#url
      # @return [String]

      # @method http_method
      # @api public
      #
      # HTTP request method
      #
      # The allowed values are defined in
      # {Baleog::Client::Endpoint::HTTP_METHODS HTTP_METHODS}
      #
      # @see Client::Endpoint#http_method
      # @return [Symbol]

      # @method payload
      # @api public
      #
      # Payload to be sent on POST, PATCH and PUT requests
      #
      # @see Client::Request#payload
      # @return [Hash]

      # @method model
      # @api public
      #
      # Returns the model class to wrap the response
      #
      # @see Client::Endpoint#model
      # @return [Class<Client::Model>]
      delegate :url, :http_method, :payload, :model, to: :request
    end
  end
end
