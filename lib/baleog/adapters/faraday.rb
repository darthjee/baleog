# frozen_string_literal: true

require 'faraday'

module Baleog
  module Adapters
    # @api private
    # @author darthjee
    #
    # Faraday adapter for executing http requests
    class Faraday < Sinclair::Model
      initialize_with(:request)

      def self.call(request)
        new(request: request).call
      end

      def call
        response = ::Faraday.public_send(http_method, url) do |req|
          req.body = payload if payload
        end

        Adapters::Response.new(response)
      end

      delegate :url, :http_method, :payload, :model, to: :request
    end
  end
end
