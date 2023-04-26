# frozen_string_literal: true

class Baleog
  class Model
    autoload :Builder,      'baleog/model/builder'
    autoload :ClassMethods, 'baleog/model/class_methods'

    extend ClassMethods

    def initialize(hash = {})
      @hash = hash.stringify_keys
    end
  end
end
