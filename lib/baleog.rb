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

  autoload :Client,         'baleog/client'
  autoload :Service,        'baleog/service'
  autoload :Request,        'baleog/request'
  autoload :Endpoint,       'baleog/endpoint'
  autoload :Model,          'baleog/model'
end
