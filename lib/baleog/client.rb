# frozen_string_literal: true

module Baleog
  # @api public
  # @author darthjee
  #
  # Client object with all the endpoints
  class Client
    autoload :Endpoint,            'baleog/client/endpoint'
    autoload :EndpointBuilder,     'baleog/client/endpoint_builder'
    autoload :Model,               'baleog/client/model'
    autoload :Request,             'baleog/client/request'
    autoload :Response,            'baleog/client/response'
    autoload :Service,             'baleog/client/service'
    autoload :WithEndpoint,        'baleog/client/with_endpoint'
    autoload :WithEndpointOptions, 'baleog/client/with_endpoint_options'

    extend NestingBuilder
    extend WithEndpoint

    # @method self.with_endpoint(http_method, path, **options)
    # @api public
    #
    # Register an endpoint to the client
    #
    # @param http_method [Symbol] HTTP request method
    # @param path [String] HTTP path of the endpoint
    # @option options name [Symbol] (nil) name of the endpoint
    # @option options service [Symbol] (:default) Name of the registered service
    # @option options method_name [Symbol] (nil) Name of the method used
    #   to access the endpoint
    #
    #   When omitted, +name+ will be used instead
    #
    # @see Client::Endpoint#initialize
    # @return [Client::Endpoint]

    # @method self.with_nesting(name)
    # @api private
    #
    # Adds a nested class to be created in the list
    #
    # @param name [Symbol] Name of the nested class to be built
    #
    # @return [Symbol]
    with_nesting(:Model)
  end
end
