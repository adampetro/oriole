# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    class Schema
      class << self
        extend(T::Sig)
        extend(T::Helpers)
        include(Abstract::SchemaDefinition)

        abstract!

        sig { abstract.returns(T.class_of(ObjectType)) }
        def query; end

        sig do
          params(
            query: String,
            context: Object,
            root_value: Object,
            operation_name: T.nilable(String),
          ).returns(Object)
        end
        def execute(
          query:,
          context:,
          root_value:,
          operation_name: nil
        )
          Execution::Engine.execute(
            schema_definition: VisibilityScoped::SchemaDefinition.new(
              definition: self,
              context:,
            ),
            query:,
            context:,
            root_value:,
            operation_name:,
          )
        end
      end
    end
  end
end
