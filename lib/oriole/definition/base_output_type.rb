# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    BaseOutputType = T.type_alias do
      T.any(
        BuiltinScalarDefinition,
        Abstract::ObjectTypeDefinition,
      )
    end
  end
end
