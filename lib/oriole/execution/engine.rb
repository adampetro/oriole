# typed: strict
# frozen_string_literal: true

require "tinygql"
require "set"

module Oriole
  module Execution
    class Engine
      extend(T::Sig)

      sig do
        params(
          schema_definition: Definition::Abstract::SchemaDefinition,
          document: TinyGQL::Nodes::Document,
          context: Object,
        ).void
      end
      def initialize(schema_definition:, document:, context:)
        @schema_definition = schema_definition
        @document = document
        @context = context
        @collect_fields_cache = T.let(
          {},
          T::Hash[Integer, T::Hash[String, T::Array[TinyGQL::Nodes::Field]]],
        )
      end

      private_class_method(:new)

      class << self
        extend(T::Sig)

        sig do
          params(
            schema_definition: Definition::Abstract::SchemaDefinition,
            query: String,
            context: Object,
            operation_name: T.nilable(String),
            root_value: Object,
          ).returns(Object)
        end
        def execute(schema_definition:, query:, context:, operation_name:, root_value:)
          document = TinyGQL.parse(query)

          new(schema_definition:, document:, context:).execute(operation_name:, root_value:)
        end
      end

      sig { params(operation_name: T.nilable(String), root_value: Object).returns(Object) }
      def execute(operation_name:, root_value:)
        operation_definition = if operation_name
          @document.definitions.find do |definition|
            definition.is_a?(TinyGQL::Nodes::OperationDefinition) && definition.name == operation_name
          end || raise("Cannot find operation definition with name #{operation_name}")
        else
          operation_definitions = @document.definitions.select do |definition|
            definition.is_a?(TinyGQL::Nodes::OperationDefinition)
          end
          if operation_definitions.one?
            operation_definitions.first
          else
            raise "Cannot use anonymous operation with multiple operation definitions"
          end
        end

        execute_operation(operation_definition: operation_definition, initial_value: root_value)
      end

      private

      sig { params(operation_definition: TinyGQL::Nodes::OperationDefinition, initial_value: Object).returns(Object) }
      def execute_operation(operation_definition:, initial_value:)
        case operation_definition.type
        when "query", nil
          execute_selection_set(
            selection_set: operation_definition.selection_set,
            object_type: @schema_definition.query,
            object_value: initial_value,
          )
        else
          raise(NotImplementedError)
        end
      end

      sig do
        params(
          selection_set: T::Array[TinyGQL::Nodes::Node],
          object_type: Definition::Abstract::ObjectTypeDefinition,
          object_value: Object,
        ).returns(Object)
      end
      def execute_selection_set(selection_set:, object_type:, object_value:)
        grouped_fields = collect_fields(object_type:, selection_set:, visited_fragments: Set.new)

        result_map = {}

        has_null_for_required = T.let(false, T::Boolean)

        grouped_fields.each do |_response_key, fields|
          field_name = T.must(fields.first).name
          field_definition = object_type.field_definitions.find do |definition|
            definition.graphql_name == field_name
          end || raise("Cannot find field definition for #{field_name}")

          field_value = execute_field(
            object_type:,
            field_definition:,
            object_value:,
            fields:,
          )

          result_map[field_name] = field_value

          if field_definition.type.required? && field_value.nil?
            has_null_for_required = true
          end
        end

        result_map
      end

      sig do
        params(
          object_type: Definition::Abstract::ObjectTypeDefinition,
          selection_set: T::Array[TinyGQL::Nodes::Node],
          visited_fragments: T::Set[String],
        ).returns(T::Hash[String, T::Array[TinyGQL::Nodes::Field]])
      end
      def collect_fields(object_type:, selection_set:, visited_fragments:)
        if (cached_value = @collect_fields_cache[selection_set.object_id])
          return cached_value
        end

        grouped_fields = {}

        selection_set.each do |selection|
          # TODO: handle include/skip directives

          case selection
          when TinyGQL::Nodes::Field
            response_key = selection.aliaz || selection.name
            grouped_fields[response_key] ||= []
            grouped_fields[response_key] << selection
          else
            raise NotImplementedError
          end
        end

        @collect_fields_cache[selection_set.object_id] = grouped_fields

        grouped_fields
      end

      sig do
        params(
          object_type: Definition::Abstract::ObjectTypeDefinition,
          object_value: Object,
          field_definition: Definition::Abstract::FieldDefinition,
          fields: T::Array[TinyGQL::Nodes::Field],
        ).returns(Object)
      end
      def execute_field(object_type:, object_value:, field_definition:, fields:)
        resolved_value = object_value.send(field_definition.resolver_method_name)

        complete_value(field_type: field_definition.type, fields:, resolved_value:)
      end

      sig do
        params(
          field_type: Definition::OutputType,
          fields: T::Array[TinyGQL::Nodes::Field],
          resolved_value: Object,
        ).returns(Object)
      end
      def complete_value(field_type:, fields:, resolved_value:)
        if resolved_value.nil? && field_type.required?
          raise "Cannot return null for non-null list type"
        elsif resolved_value.nil?
          return
        end

        case field_type
        when Definition::OutputType::Named
          case (inner_type = field_type.inner)
          when BuiltinScalarDefinition
            inner_type.coerce_result(result: resolved_value)
          when Definition::Abstract::ObjectTypeDefinition
            execute_selection_set(
              selection_set: T.must(fields.first).selection_set,
              object_type: inner_type,
              object_value: resolved_value,
            )
          end
        when Definition::OutputType::List
          if resolved_value.is_a?(Array)
            resolved_value.map do |value|
              complete_value(field_type: field_type.inner, fields: fields, resolved_value: value)
            end
          else
            raise "Cannot return non-list value for list type"
          end
        end
      end
    end
  end
end
