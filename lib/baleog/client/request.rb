# frozen_string_literal: true

module Baleog
  class Client
    # @api private
    # @author darthjee
    #
    # Class representing a request to be made against an endpoint
    class Request < Sinclair::Model
      initialize_with(:endpoint, { headers: {}, payload: nil }, **{})

      def call
        Baleog::Adapters.adapter(:faraday).call(self)
      end

      def url
        [base_url, path.gsub(%r{^/}, '')].join('/')
      end

      delegate :service, :path, :model, :http_method, to: :endpoint
      delegate :base_url, to: :service
    end
  end
end
