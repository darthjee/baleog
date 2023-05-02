# frozen_string_literal: true

module Baleog
  class Model
    autoload :Builder,      'baleog/model/builder'
    autoload :ClassMethods, 'baleog/model/class_methods'
    autoload :ValueWrapper, 'baleog/model/value_wrapper'

    extend ClassMethods
    include Sinclair::Comparable

    comparable_by :@hash

    def self.build
      Class.new(self) do |klass|
        klass.const_set(:ValueWrapper, ValueWrapper.build)
      end
    end

    def initialize(hash = {})
      @hash = hash.stringify_keys
    end
  end
end
