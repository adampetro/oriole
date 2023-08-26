# typed: true
# frozen_string_literal: true

require "test_helper"

module Oriole
  class ExecutionTest < Minitest::Test
    class QueryRoot < Definition::ObjectType
      class << self
        extend(T::Sig)

        sig { override.returns(T::Array[Definition::FieldDefinition]) }
        def field_definitions
          [
            Definition::FieldDefinition.new(
              graphql_name: "hello",
              type: Definition::OutputType.named(BuiltinScalarDefinition::String),
            ),
          ]
        end
      end
    end

    class Schema < Definition::Schema
      class << self
        extend(T::Sig)

        sig { override.returns(T.class_of(Definition::ObjectType)) }
        def query
          QueryRoot
        end
      end
    end

    class RootValue < T::Struct
      const(:hello, String)
    end

    def test_execute
      assert_equal(
        {
          "hello" => "world",
        },
        Schema.execute(
          query: "{ hello }",
          root_value: RootValue.new(hello: "world"),
          context: nil,
        ),
      )
    end
  end
end
