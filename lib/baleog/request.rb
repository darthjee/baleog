# frozen_string_literal: true

module Baleog
  class Request < Sinclair::Model
    initialize_with(:endpoint, { headers: {}, payload: nil }, **{})

    def call
    end
  end
end
