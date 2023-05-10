# frozen_string_literal: true

module Baleog
  class Client
    module WithEndpoint
      def with_endpoint(http_method, path, name: nil, method_name: name)
        Client::EndpointBuilder.build(self) do
          add_endpoint(method_name, name: name)
        end
      end

      def endpoints
        @endpoints ||= {}
      end
    end
  end
end
