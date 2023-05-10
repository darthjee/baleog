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
      def add_endpoint(method_name)
        return unless method_name

        add_method(method_name) {}
      end

      def build
        super

        endpoint
      end

      def endpoint
        @endpoint ||= Endpoint.new(options.endpoint_options)
      end
    end
  end
end
