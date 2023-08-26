# typed: ignore
# frozen_string_literal: true

require_relative "bench"
require_relative "schemas/bluejay"
require_relative "schemas/oriole"
require_relative "schemas/models"

Bench.all do |x|
  root_value = Schemas::Models::QueryRoot.new(teams: Schemas::Models::Team.all)
  schema_root_value = Schemas::Models::SchemaRoot.new(query: root_value)
  query = <<~GQL
    {
      teams {
        __typename
        name
        city
        players {
          __typename
          firstName
          lastName
          age
          draftPosition { __typename round selection year }
        }
      }
    }
  GQL

  oriole_visibility_test_run = Schemas::Oriole::Schema.execute(query:, root_value:, context: nil)
  oriole_no_visibility_test_run = Oriole::Execution::Engine.execute(
    schema_definition: Schemas::Oriole::Schema,
    query:,
    context: nil,
    operation_name: nil,
    root_value:,
  )
  bluejay_test_run = Schemas::Bluejay::Schema.execute(query:, operation_name: nil, initial_value: schema_root_value)

  unless bluejay_test_run.errors.empty?
    raise "errors returned"
  end

  unless oriole_visibility_test_run == bluejay_test_run.value && oriole_no_visibility_test_run == bluejay_test_run.value
    raise "results not equal"
  end

  x.report(:oriole_visibility) do
    Schemas::Oriole::Schema.execute(query:, root_value:, context: nil)
  end

  x.report(:oriole_no_visibility) do
    Oriole::Execution::Engine.execute(
      schema_definition: Schemas::Oriole::Schema,
      query:,
      context: nil,
      operation_name: nil,
      root_value:,
    )
  end

  x.report(:bluejay) do
    Schemas::Bluejay::Schema.execute(query:, operation_name: nil, initial_value: schema_root_value)
  end

  x.compare!
end
