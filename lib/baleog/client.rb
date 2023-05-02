# frozen_string_literal: true

module Baleog
  class Client
    def self.build
      Class.new(self)
    end
  end
end
