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

    def initialize(path: nil, http_method: :get)
      @path        = path
      @http_method = http_method
    end
  end
end
