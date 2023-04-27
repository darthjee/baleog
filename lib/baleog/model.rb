# frozen_string_literal: true

class Baleog
  class Model
    autoload :Builder,      'baleog/model/builder'
    autoload :ClassMethods, 'baleog/model/class_methods'
    autoload :ValueWrapper, 'baleog/model/value_wrapper'

    extend ClassMethods

    def initialize(hash = {})
      case hash
      when Hash
        @hash = hash.stringify_keys
      when String
        @hash = JSON.parse(hash)
      end
    end
  end
end
