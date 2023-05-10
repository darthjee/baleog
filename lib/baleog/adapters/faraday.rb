# frozen_string_literal: true

require 'faraday'

module Baleog
  module Adapters
    # @api private
    # @author darthjee
    #
    # Faraday adapter for executing http requests
    class Faraday < Adapters::Base
      # Makes an HTTP request against an enndpoint
      #
      # @return [Adapters::Response]
      def call
        response = ::Faraday.public_send(http_method, url) do |req|
          req.body = payload if payload
        end

        Adapters::Response.new(response)
      end
    end
  end
end
