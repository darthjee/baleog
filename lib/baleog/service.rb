# frozen_string_literal: true

module Baleog
  # @api private
  # @author darthjee
  #
  # Class representing a service the client conects to
  #
  # A service is usually defined by a base URL
  class Service < Sinclair::Model
    initialize_with(:base_url)
  end
end
