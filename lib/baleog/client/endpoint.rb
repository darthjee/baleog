# frozen_string_literal: true

module Baleog
  class Client
    # @api private
    # @author darthjee
    #
    # This represents an endpoint to a service
    class Endpoint < Sinclair::Model
      # Available HTTP methods for an endpoint
      HTTP_METHODS = %i[get post delete patch].freeze
      DEFAULTS = { http_method: :get, model: nil, name: nil }.freeze

      initialize_with :path, :service, DEFAULTS, **{}

      # @!method initialize(path:, service:, http_method: :get, model: nil, name: nil)
      # @api private
      # @param path [String] Path of the endpoint
      # @param service [Service] service configuration
      # @param http_method [Symbol] HTTP method to be used.
      #   Available options are defined in {HTTP_METHODS}
      # @param model [Model] model class to wrap the response
      # @param name [Symbol] name of the endpoint

      # @method path
      # @api private
      #
      # Endpoint path where the request will be made
      #
      # @return [String] the endpoint path

      # @method http_method
      # @api private
      #
      # Endpoint http method, or action, that will be used in the endpoint
      #
      # The available list is included in {HTTP_METHODS}
      #
      # @return [Symbol] the http method

      # @method service
      # @api private
      #
      # Returns the service object owning the endpoint
      #
      # @return [Client::Service]

      # @method model
      # @api private
      #
      # Returns the model class to wrap the response
      #
      # @return [Class<Client::Model>]

      # @method name
      # @api private
      #
      # Returns the name of the endpoint
      #
      # @return [Symbol]
    end
  end
end
