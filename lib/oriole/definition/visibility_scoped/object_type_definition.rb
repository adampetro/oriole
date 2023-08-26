# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    module VisibilityScoped
      class ObjectTypeDefinition
        extend(T::Sig)
        include(Abstract::ObjectTypeDefinition)

        sig { params(definition: T.class_of(ObjectType), context: Object).void }
        def initialize(definition:, context:)
          @definition = definition
          @context = context
          @field_definitions = T.let(nil, T.nilable(T::Array[FieldDefinition]))
        end

        class << self
          extend(T::Sig)

          sig { params(definition: T.class_of(ObjectType), context: Object).returns(T.nilable(T.attached_class)) }
          def build(definition:, context:)
            if definition.visible?(context:)
              new(definition: definition, context: context)
            end
          end
        end

        sig { override.returns(String) }
        def graphql_name = @definition.graphql_name

        sig { override.returns(T.nilable(String)) }
        def description = @definition.description

        sig { override.returns(T::Array[FieldDefinition]) }
        def field_definitions
          @field_definitions ||= @definition.field_definitions.filter_map do |field_definition|
            next nil unless field_definition.visible?(context: @context)

            base_type = field_definition.type.base

            scoped_base_type = if base_type.is_a?(Class) && base_type < ObjectType
              ObjectTypeDefinition.build(definition: base_type, context: @context)
            else
              base_type
            end

            if scoped_base_type
              FieldDefinition.new(
                graphql_name: field_definition.graphql_name,
                description: field_definition.description,
                type: field_definition.type.with_base(scoped_base_type),
                visibility: field_definition.visibility,
                method_name: field_definition.method_name,
              )
            end
          end
        end
      end
    end
  end
end
