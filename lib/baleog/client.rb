# frozen_string_literal: true

module Baleog
  class Client
    def self.build
      ClassBuilder.build(self)
    end
  end
end
