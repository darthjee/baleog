# frozen_string_literal: true

require 'faraday'

module Baleog
  class Request < Sinclair::Model
    initialize_with(:endpoint, { headers: {}, payload: nil }, **{})

    def call
      url = [base_url, path.gsub(%r{^/}, '')].join('/')
      response = Faraday.get(url)

      return JSON.parse(response.body) unless model

      Response.new(response: response, request: self)
    end

    delegate :service, :path, :model, to: :endpoint
    delegate :base_url, to: :service
  end
end
