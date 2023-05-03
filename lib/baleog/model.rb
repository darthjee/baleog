# frozen_string_literal: true

module Baleog
  class Model
    autoload :Builder,      'baleog/model/builder'
    autoload :ClassMethods, 'baleog/model/class_methods'
    autoload :ValueWrapper, 'baleog/model/value_wrapper'

    extend ClassMethods
    extend ClassBuildable
    include Sinclair::Comparable

    comparable_by :@hash
    build_from(self)
    build_with(:ValueWrapper) { ValueWrapper.build }

    def initialize(hash = {})
      @hash = hash.stringify_keys
    end
  end
end
