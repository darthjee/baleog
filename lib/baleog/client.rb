# frozen_string_literal: true

module Baleog
  class Client
    def self.old_build
      OldClassBuilder.build(self)
    end
  end
end
