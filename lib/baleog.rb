# frozen_string_literal: true

require 'sinclair'

# @api public
# @author darthjee
module Baleog
  autoload :VERSION, 'baleog/version'

  autoload :Client,   'baleog/client'
  autoload :Endpoint, 'baleog/endpoint'
  autoload :Model,    'baleog/model'

  def self.build
    Module.new.tap do |mod|
      mod.const_set(:Model, Class.new(Baleog::Model))
      mod.const_set(:Client, Class.new(Baleog::Client))
    end
  end
end
