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
      def with_endpoint(http_method, path, name: nil, method_name: name)
        endpoint_options = {
          name: name, http_method: http_method, path: path, service: nil
        }

        Client::EndpointBuilder.build(self, endpoint_options) do
          add_endpoint(method_name)
        end
      end

      def endpoints
        @endpoints ||= {}
      end
    end
  end
end
