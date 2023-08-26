# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    module VisibilityScoped
      class SchemaDefinition
        extend(T::Sig)
        include(Abstract::SchemaDefinition)

        sig { params(definition: T.class_of(Schema), context: Object).void }
        def initialize(definition:, context:)
          @definition = definition
          @context = context
          @query = T.let(
            ObjectTypeDefinition.new(definition: @definition.query, context: @context),
            ObjectTypeDefinition,
          )
        end

        sig { override.returns(ObjectTypeDefinition) }
        attr_reader(:query)
      end
    end
  end
end
