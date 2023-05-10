# frozen_string_literal: true

module Baleog
  class Client
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
        @endpoint ||= Endpoint.new(options)
      end
    end
  end
end
