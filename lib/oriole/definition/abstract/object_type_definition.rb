# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    module Abstract
      module ObjectTypeDefinition
        extend(T::Sig)
        extend(T::Helpers)
        include(Definition)

        requires_ancestor { Kernel }

        abstract!

        sig { abstract.returns(T::Array[FieldDefinition]) }
        def field_definitions; end
      end
    end
  end
end
