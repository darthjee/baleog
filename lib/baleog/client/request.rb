# frozen_string_literal: true

require 'faraday'

module Baleog
  class Client
    # @api private
    # @author darthjee
    #
    # Class representing a request to be made against an endpoint
    class Request < Sinclair::Model
      initialize_with(:endpoint, { headers: {}, payload: nil }, **{})

      def call
        url = [base_url, path.gsub(%r{^/}, '')].join('/')

        response = Faraday.public_send(http_method, url) do |req|
          req.body = payload if payload
        end

        return JSON.parse(response.body) unless model

        Response.new(response: response, request: self)
      end

      delegate :service, :path, :model, :http_method, to: :endpoint
      delegate :base_url, to: :service
    end
  end
end
