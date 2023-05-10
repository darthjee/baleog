# frozen_string_literal: true

module Baleog
  # @api public
  # @author darthjee
  #
  # Client object with all the endpoints
  class Client
    autoload :Endpoint,        'baleog/client/endpoint'
    autoload :EndpointBuilder, 'baleog/client/endpoint_builder'
    autoload :Model,           'baleog/client/model'
    autoload :Request,         'baleog/client/request'
    autoload :Response,        'baleog/client/response'
    autoload :Service,         'baleog/client/service'
    autoload :WithEndpoint,    'baleog/client/with_endpoint'

    extend NestingBuilder
    extend WithEndpoint

    # @method self.with_nesting(name)
    # @api public
    #
    # Adds a nested class to be created in the list
    #
    # @param name [Symbol] Name of the nested class to be built
    #
    # @return [Symbol]
    with_nesting(:Model)
  end
end
