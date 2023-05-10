# frozen_string_literal: true

module Baleog
  class Client
    # @api private
    # @author darthjee
    #
    # Class representing a request to be made against an endpoint
    class Request < Sinclair::Model
      initialize_with(:endpoint, { headers: {}, payload: nil }, **{})

      # @method initialize(endpoint:, headers: {}, payload: nil)
      # @api private
      #
      # @param endpoint [Baleog::Endpoint] Endpoint where the request
      #   will happen
      # @param headers [Hash] Custom request headers
      # @param payload [Hash] Payload to be sent on POST, PATCH and PUT requests

      # @method payload
      # @api public
      #
      # Payload to be sent on POST, PATCH and PUT requests
      #
      # @return [Hash]

      # @method headers
      # @api public
      #
      # Custom request headers
      #
      # @return [Hash]

      # Request the endpoint
      #
      # The request is done using the {Baleog::Adapters.adapter adapter}
      #
      # @return [Client::Response]
      def call
        response = Baleog::Adapters.adapter(:faraday).call(self)

        Client::Response.new(response: response, request: self)
      end

      # Url for the endpoint where the request will happen
      #
      # @return [String]
      def url
        [base_url, path.gsub(%r{^/}, '')].join('/')
      end

      # @method service
      # @api private
      #
      # Returns the service object owning the endpoint
      #
      # @see Client::Endpoint#service
      #
      # @return [Client::Service]

      # @method path
      # @api private
      #
      # Returns the endpoint path
      #
      # @see Client::Endpoint#path
      #
      # @return [String]

      # @method model
      # @api private
      #
      # Returns the model class to wrap the response
      #
      # @see Client::Endpoint#model
      #
      # @return [Class<Client::Model>]
      delegate :service, :path, :model, :http_method, to: :endpoint

      # @method base_url
      # @api private
      #
      # Returns the service configured base URL
      #
      # @see Client::Service#base_url
      #
      # @return [String]
      delegate :base_url, to: :service
    end
  end
end
