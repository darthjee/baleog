# frozen_string_literal: true

require 'sinclair'

# @api public
# @author darthjee
#
# Module responsible for building clients
#
# This module is the entrypoint when building Baelog clients
module Baleog
  autoload :VERSION, 'baleog/version'

  autoload :Adapters,       'baleog/adapters'
  autoload :Client,         'baleog/client'
  autoload :NestingBuilder, 'baleog/nesting_builder'
end
