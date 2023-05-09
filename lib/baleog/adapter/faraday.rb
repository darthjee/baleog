# frozen_string_literal: true

require 'faraday'

module Baleog
  class Adapter
    class Faraday < Sinclair::Model
      initialize_with(:request)

      def self.call(request)
        new(request: request).call
      end

      def call
        url = [base_url, path.gsub(%r{^/}, '')].join('/')

        response = ::Faraday.public_send(http_method, url) do |req|
          req.body = payload if payload
        end

        return JSON.parse(response.body) unless model

        Client::Response.new(response: response, request: request)
      end

      delegate :base_url, :path, :http_method, :payload, :model, to: :request
    end
  end
end
