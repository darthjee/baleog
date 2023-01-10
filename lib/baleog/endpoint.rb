# frozen_string_literal: true

class Baleog
  ###
  #
  # @api private
  # @author darthjee
  #
  # This represents an endpoint to a service
  class Endpoint
    attr_reader :path, :http_method

    HTTP_METHODS = %i[get post delete patch].freeze

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

    def initialize(path: nil, http_method: :get)
      @path        = path
      @http_method = http_method
    end
  end
end
