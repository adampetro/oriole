# typed: strict
# frozen_string_literal: true

module Oriole
  class BuiltinScalarDefinition < T::Enum
    extend(T::Sig)
    include(Execution::CoerceResult)

    enums do
      Int = new
      Float = new
      String = new
      Boolean = new
      ID = new
    end

    sig { override.params(result: Object).returns(Object) }
    def coerce_result(result:)
      case self
      when Int
        if result.is_a?(Integer) && result < T.cast(2**31, Integer) && result >= T.cast(-2**31, Integer)
          result
        else
          raise "Value not an i32"
        end
      when Float
        if result.is_a?(Numeric) && result.finite?
          result
        else
          raise "Value not a finite float"
        end
      when String
        if result.is_a?(::String)
          result
        else
          raise "Value not a string"
        end
      when Boolean
        if result == true || result == false
          result
        else
          raise "Value not a boolean"
        end
      when ID
        if result.is_a?(::String) || result.is_a?(Integer)
          result
        else
          raise "Value not a string or integer"
        end
      end
    end
  end
end
