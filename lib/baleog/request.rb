# frozen_string_literal: true

require 'faraday'

module Baleog
  class Request < Sinclair::Model
    initialize_with(:endpoint, { headers: {}, payload: nil }, **{})

    def call
    end
  end
end
