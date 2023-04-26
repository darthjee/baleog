# frozen_string_literal: true

class Baleog
  class Model
    autoload :ClassMethods, 'baleog/model/class_methods'

    extend ClassMethods

    def initialize(hash = {})
    end
  end
end
