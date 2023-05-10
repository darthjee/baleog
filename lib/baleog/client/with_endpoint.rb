# frozen_string_literal: true

module Baleog
  class Client
    # @api public
    # @author darthjee
    #
    # Module to add endpoints and methods to a client
    #
    # Endpoints can be added with or without a direct
    # method to access it
    module WithEndpoint
      # (see Client.with_endpoint)
      def with_endpoint(http_method, path, **options)
        options_hash = options.merge(
          http_method: http_method, path: path
        )

        build_options = WithEndpointOptions.new(options_hash)

        Client::EndpointBuilder.build(self, build_options)
      end

      private

      # Map of all named {Endpoint endpoints}
      # @private
      #
      # @return [Hash<Symbol, Client::Endpoint>]
      def endpoints
        @endpoints ||= {}
      end
    end
  end
end
