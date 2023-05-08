# frozen_string_literal: true

module Baleog
  class ClassBuilder < Sinclair::Model
    initialize_with :parent_module, :name

    def self.build(parent_module, name)
      new(
        parent_module: parent_module,
        name: name
      ).build
    end

    def build
      block.call(parent_module)
    end

    private

    def code
      <<-RUBY
        proc do |parent_module|
          class parent_module::#{name} < parent_module.superclass::#{name}
          end
        end
      RUBY
    end

    def block
      eval(code)
    end
  end
end
