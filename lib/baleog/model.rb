# frozen_string_literal: true

class Baleog
  class Model
    autoload :Builder,      'baleog/model/builder'
    autoload :ClassMethods, 'baleog/model/class_methods'
    autoload :ValueWrapper, 'baleog/model/value_wrapper'

    extend ClassMethods
    include Sinclair::Comparable

    comparable_by :@hash

    def initialize(hash = {})
      @hash = hash.stringify_keys
    end
  end
end
