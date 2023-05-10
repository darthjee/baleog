# frozen_string_literal: true

module Baleog
  class Client
    # @api private
    # @author darthjee
    #
    # Endpoint building options
    class WithEndpointOptions < ::Sinclair::Options
      with_options(:name, :http_method, :path, :service, :method_name)

      def endpoint_options
        {
          name: name, http_method: http_method, path: path, service: nil
        }
      end

      def method_name
        @method_name ||= name
      end
    end
  end
end
