# frozen_string_literal: true

module Baleog
  class Client
    def self.build
      OldClassBuilder.build(self)
    end
  end
end
