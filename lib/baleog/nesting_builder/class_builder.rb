# frozen_string_literal: true

module Baleog
  module NestingBuilder
    # @api private
    # @author darthjee
    #
    # Module responsible for generating a new class nested
    #
    # The new class will be based on a class nested in the superclass
    # under the same name.
    #
    # This is required to enable different configurations for different
    # clients
    module ClassBuilder
      # Builds a new instance of a nested class
      #
      # @example Final result
      #   class A
      #     class B
      #     end
      #   end
      #
      #   class C < A
      #   end
      #
      #   # build runs generating C::B < A::B
      #
      # @return [NilClass]
      def self.build(parent_module, name)
        code = <<-RUBY
        proc do |parent_module|
          class parent_module::#{name} < parent_module.superclass::#{name}
          end
        end
        RUBY

        Object.instance_eval(code).call(parent_module)
      end
    end
  end
end
