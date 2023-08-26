# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    module Abstract
      module SchemaDefinition
        extend(T::Sig)
        extend(T::Helpers)

        abstract!

        sig { abstract.returns(ObjectTypeDefinition) }
        def query; end
      end
    end
  end
end
