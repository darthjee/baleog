# frozen_string_literal: true

module Baleog
  # @api public
  # @author darthjee
  #
  # Class representing a response from the API
  #
  # This classes wraps the response from the HTTP request
  # library used by the connector
  class Response < Sinclair::Model
    initialize_with(:response, :request)

    delegate :status, :body, to: :response
    delegate :model, to: :request

    def parsed_body
      @parsed_body ||= JSON.parse(body)
    end

    def object
      return parsed_body unless model

      model.from(parsed_body)
    end
  end
end
