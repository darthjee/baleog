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
      # Default initialization method
      DEFAULTS = { http_method: :get, model: nil, name: nil }.freeze

      initialize_with :path, :service, DEFAULTS, **{}

      # @!method initialize(options)
      # @api private
      # @option options path [String] Path of the endpoint
      # @option options service [Service] service configuration
      # @option options http_method [Symbol] (:get) HTTP method to be used.
      #   Available options are defined in {HTTP_METHODS}
      # @option options model [Model] (nil) model class to wrap the response
      # @option options name [Symbol] (nil) name of the endpoint
      #
      # @see DEFAULTS
      # @see HTTP_METHODS

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
