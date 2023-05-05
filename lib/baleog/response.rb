# frozen_string_literal: true

module Baleog
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
