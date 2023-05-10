# frozen_string_literal: true

module Baleog
  class Client
    # @api private
    # @author darthjee
    #
    # Class responsible for building an endpoint in a client
    #
    # The endpoint is built and attached to a method to be accessible
    # from the client
    class EndpointBuilder < Sinclair
      # Builds a method to access the built endpoint
      #
      # Build only happens when a method name has been given
      #
      # @return [Array<Sinclair::MethodDefinition>]
      def add_endpoint_method
        return unless method_name

        add_method(method_name) {}
      end

      # Builds an endpoint and adds a method to access it
      #
      # When method name is not provided, only the
      # endpoint is built
      #
      # @return [Client::Endpoint]
      def build
        add_endpoint_method

        super

        endpoint
      end

      private

      delegate :method_name, :endpoint_options, to: :options

      def endpoint
        @endpoint ||= Endpoint.new(**endpoint_options)
      end
    end
  end
end
