# frozen_string_literal: true

require 'faraday'

module Baleog
  class Request < Sinclair::Model
    initialize_with(:endpoint, { headers: {}, payload: nil }, **{})

    def call
      url = [base_url, path.gsub(/^\//,'')].join('/')
      response = Faraday.get(url)
    end

    delegate :service, :path, to: :endpoint
    delegate :base_url, to: :service
  end
end
