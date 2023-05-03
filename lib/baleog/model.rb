# frozen_string_literal: true

module Baleog
  # @api public
  # @author darthjee
  #
  # Model class representing JSON responses and requests
  #
  # Model is capable of wrapping a JSON nad exposing it's
  # fields using class methods
  class Model
    autoload :Builder,      'baleog/model/builder'
    autoload :ClassMethods, 'baleog/model/class_methods'
    autoload :ValueWrapper, 'baleog/model/value_wrapper'

    extend ClassMethods
    extend ClassBuildable
    include Sinclair::Comparable

    comparable_by :@hash
    build_with(ValueWrapper)

    # @param hash [Hash] hash from request or response
    def initialize(hash = {})
      @hash = hash.stringify_keys
    end
  end
end
