# frozen_string_literal: true

module Baleog
  class Client
    # @api private
    # @author darthjee
    #
    # Endpoint building options
    class WithEndpointOptions < ::Sinclair::Options
      with_options(:name, :http_method, :path, :service, :method_name)

      # @method initialize(**options)
      # @api private
      #
      # @option options http_method [Symbol] HTTP request method
      # @option options path [String] HTTP path of the endpoint
      # @option (see Client.with_endpoint)

      # Options hash for creating a new {Client::Endpoint Endpoint}
      def endpoint_options
        {
          name: name, http_method: http_method, path: path, service: service
        }
      end

      # @method http_method
      # @api private
      #
      # HTTP request method
      #
      # @return [Symbol]

      # @method path
      # @api private
      #
      # HTTP path of the endpoint
      #
      # @return [String]

      # @method name
      # @api private
      #
      # Name of the endpoint
      #
      # @return [Symbol]

      # @method service
      # @api private
      #
      # Name of the registered service
      #
      # @return [Symbol]

      # @method method_name
      # @api private
      #
      # Method name to be used when accessing the endpoint
      #
      # When omitted, +name+ will be used instead
      #
      # @return [Symbol]
      def method_name
        @method_name ||= name
      end
    end
  end
end
