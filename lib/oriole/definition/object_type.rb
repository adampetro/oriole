# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    class ObjectType
      class << self
        extend(T::Sig)
        extend(T::Helpers)
        include(Definition::Abstract::ObjectTypeDefinition)

        abstract!

        sig { overridable.returns(T.nilable(Abstract::Visibility)) }
        def visibility
          nil
        end

        sig { override.returns(String) }
        def graphql_name
          name&.split("::")&.last || "Anonymous"
        end

        sig { override.returns(T.nilable(String)) }
        def description
        end

        sig { abstract.returns(T::Array[FieldDefinition]) }
        def field_definitions; end

        sig { params(context: Object).returns(T::Boolean) }
        def visible?(context:)
          visibility = self.visibility

          visibility ? visibility.visible?(context: context) : true
        end
      end
    end
  end
end
