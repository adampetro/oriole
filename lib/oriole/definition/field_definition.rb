# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    class FieldDefinition < T::Struct
      extend(T::Sig)
      include(Abstract::FieldDefinition)

      const(:graphql_name, String)
      const(:description, T.nilable(String))
      const(:type, OutputType)
      const(:visibility, T.nilable(Abstract::Visibility))
      const(:method_name, T.nilable(String))

      sig { params(context: Object).returns(T::Boolean) }
      def visible?(context:)
        @visibility ? @visibility.visible?(context: context) : true
      end

      sig { override.returns(String) }
      def resolver_method_name
        @method_name || @graphql_name
      end
    end
  end
end
