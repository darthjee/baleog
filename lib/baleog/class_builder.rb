# frozen_string_literal: true

module Baleog
  class ClassBuilder
    def self.build(parent_module, name)
      code = <<-RUBY
        proc do |parent_module|
          class parent_module::#{name} < parent_module.superclass::#{name}
          end
        end
      RUBY

      prc = eval(code)

      prc.call(parent_module)
    end
  end
end
