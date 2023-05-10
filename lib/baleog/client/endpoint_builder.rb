# frozen_string_literal: true

module Baleog
  class Client
    class EndpointBuilder < Sinclair
      def add_endpoint(method_name, **options)
        add_method(method_name) {}
      end
    end
  end
end
