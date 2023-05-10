# frozen_string_literal: true

module Baleog
  # @api public
  # @author darthjee
  #
  # Client object with all the endpoints
  class Client
    extend NestingBuilder

    autoload :Endpoint, 'baleog/client/endpoint'
    autoload :Model,    'baleog/client/model'
    autoload :Request,  'baleog/client/request'
    autoload :Response, 'baleog/client/response'
    autoload :Service,  'baleog/client/service'

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
