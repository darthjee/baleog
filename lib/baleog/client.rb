# frozen_string_literal: true

module Baleog
  # @api public
  # @author darthjee
  #
  # Client object with all the endpoints
  class Client
    autoload :Endpoint, 'baleog/client/endpoint'
    autoload :Model,    'baleog/client/model'
    autoload :Request,  'baleog/client/request'
    autoload :Response, 'baleog/client/response'
    autoload :Service,  'baleog/client/service'

    class << self
      def build_nested_classes
        ClassBuilder.build(self, :Model)
        ClassBuilder.build(self::Model, :ValueWrapper)
      end

      def configure
        build_nested_classes
      end
    end
  end
end
