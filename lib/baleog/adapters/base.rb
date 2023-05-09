# frozen_string_literal: true

module Baleog
  module Adapters
    class Base < Sinclair::Model
      initialize_with(:request)

      def self.call(request)
        new(request: request).call
      end

      def call
        raise NotImplementedError,
              'This needs to be implemented in the child class'
      end

      delegate :url, :http_method, :payload, :model, to: :request
    end
  end
end
