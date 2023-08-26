# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    module Abstract
      module FieldDefinition
        extend(T::Sig)
        extend(T::Helpers)
        include(Definition)

        abstract!

        sig { abstract.returns(OutputType) }
        def type; end

        sig { abstract.returns(String) }
        def resolver_method_name; end
      end
    end
  end
end
