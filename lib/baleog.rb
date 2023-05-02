# frozen_string_literal: true

require 'sinclair'

# @api public
# @author darthjee
module Baleog
  autoload :VERSION, 'baleog/version'

  autoload :ClassBuildable,  'baleog/class_buildable'
  autoload :OldClassBuilder, 'baleog/old_class_builder'
  autoload :Client,          'baleog/client'
  autoload :Endpoint,        'baleog/endpoint'
  autoload :Model,           'baleog/model'

  def self.build
    OldClassBuilder.build(Module) do |mod|
      mod.const_set(:Model, Model.build)
      mod.const_set(:Client, Client.build)
    end
  end
end
