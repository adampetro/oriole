# typed: strict
# frozen_string_literal: true

module Schemas
  module Oriole
    class DraftPosition < ::Oriole::Definition::ObjectType
      class << self
        extend(T::Sig)

        sig { override.returns(T::Array[::Oriole::Definition::FieldDefinition]) }
        def field_definitions
          @field_definitions ||= T.let(
            [
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "__typename",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::String),
                method_name: "resolve_typename",
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "round",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::Int),
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "selection",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::Int),
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "year",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::Int),
              ),
            ],
            T.nilable(T::Array[::Oriole::Definition::FieldDefinition]),
          )
        end
      end
    end

    class Player < ::Oriole::Definition::ObjectType
      class << self
        extend(T::Sig)

        sig { override.returns(T::Array[::Oriole::Definition::FieldDefinition]) }
        def field_definitions
          @field_definitions ||= T.let(
            [
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "__typename",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::String),
                method_name: "resolve_typename",
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "firstName",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::String),
                method_name: "first_name",
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "lastName",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::String),
                method_name: "last_name",
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "age",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::Int),
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "draftPosition",
                type: ::Oriole::Definition::OutputType.named(DraftPosition),
                method_name: "draft_position",
              ),
            ],
            T.nilable(T::Array[::Oriole::Definition::FieldDefinition]),
          )
        end
      end
    end

    class Team < ::Oriole::Definition::ObjectType
      class << self
        extend(T::Sig)

        sig { override.returns(T::Array[::Oriole::Definition::FieldDefinition]) }
        def field_definitions
          @field_definitions ||= T.let(
            [
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "__typename",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::String),
                method_name: "resolve_typename",
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "name",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::String),
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "city",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::String),
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "players",
                type: ::Oriole::Definition::OutputType.list!(::Oriole::Definition::OutputType.named!(Player)),
              ),
            ],
            T.nilable(T::Array[::Oriole::Definition::FieldDefinition]),
          )
        end
      end
    end

    class QueryRoot < ::Oriole::Definition::ObjectType
      class << self
        extend(T::Sig)

        sig { override.returns(T::Array[::Oriole::Definition::FieldDefinition]) }
        def field_definitions
          @field_definitions ||= T.let(
            [
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "__typename",
                type: ::Oriole::Definition::OutputType.named!(::Oriole::BuiltinScalarDefinition::String),
                method_name: "resolve_typename",
              ),
              ::Oriole::Definition::FieldDefinition.new(
                graphql_name: "teams",
                type: ::Oriole::Definition::OutputType.list!(::Oriole::Definition::OutputType.named!(Team)),
              ),
            ],
            T.nilable(T::Array[::Oriole::Definition::FieldDefinition]),
          )
        end
      end
    end

    class Schema < ::Oriole::Definition::Schema
      class << self
        extend(T::Sig)

        sig { override.returns(T.class_of(::Oriole::Definition::ObjectType)) }
        def query
          QueryRoot
        end
      end
    end
  end
end
