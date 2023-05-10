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
      def with_endpoint(http_method, path, **options)
        build_options = WithEndpointOptions.new(options.merge(
          http_method: http_method, path: path
        ))

        Client::EndpointBuilder.build(self, build_options) do
          add_endpoint(build_options.method_name)
        end
      end

      def endpoints
        @endpoints ||= {}
      end
    end
  end
end
