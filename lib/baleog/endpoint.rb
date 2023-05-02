# frozen_string_literal: true

module Baleog
  ###
  #
  # @api private
  # @author darthjee
  #
  # This represents an endpoint to a service
  class Endpoint < Sinclair::Model
    initialize_with :path, { http_method: :get }, **{}

    # Available HTTP methods for an endpoint
    HTTP_METHODS = %i[get post delete patch].freeze

    # @!method initialize(path:, http_method: :get)
    # @param path [String] Path of the endpoint
    # @param http_method [Symbol] HTTP method to be used.
    #   Available options are defined in {HTTP_METHODS}

    # @method path
    #
    # Endpoint path where the request will be made
    #
    # @return [String] the endpoint path

    # @method http_method
    #
    # Endpoint http method, or action, that will be used in the endpoint
    #
    # The available list is included in {HTTP_METHODS}
    #
    # @return [Symbol] the http method
  end
end
