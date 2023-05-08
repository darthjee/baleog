# frozen_string_literal: true

module Baleog
  # @api public
  # @author darthjee
  #
  # Client object with all the endpoints
  class Client
    autoload :Endpoint, 'baleog/client/endpoint'
    autoload :Service, 'baleog/client/service'
  end
end
