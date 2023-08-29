# typed: strict
# frozen_string_literal: true

module Oriole
  module BuiltinScalarDefinition
    extend(T::Sig)
    extend(T::Helpers)
    include(Execution::CoerceResult)

    sealed!
    abstract!

    requires_ancestor { Kernel }

    class IntClass
      extend(T::Sig)
      include(BuiltinScalarDefinition)

      sig { override.params(result: Object).returns(Object) }
      def coerce_result(result:)
        if result.is_a?(Integer) && result < T.cast(2**31, Integer) && result >= T.cast(-2**31, Integer)
          result
        else
          raise "Value not an i32"
        end
      end
    end
    private_constant(:IntClass)

    Int = IntClass.new

    class FloatClass
      extend(T::Sig)
      include(BuiltinScalarDefinition)

      sig { override.params(result: Object).returns(Object) }
      def coerce_result(result:)
        if result.is_a?(Numeric) && result.finite?
          result
        else
          raise "Value not a finite float"
        end
      end
    end
    private_constant(:FloatClass)

    Float = FloatClass.new

    class StringClass
      extend(T::Sig)
      include(BuiltinScalarDefinition)

      sig { override.params(result: Object).returns(Object) }
      def coerce_result(result:)
        if result.is_a?(::String)
          result
        else
          raise "Value not a string"
        end
      end
    end
    private_constant(:StringClass)

    String = StringClass.new

    class BooleanClass
      extend(T::Sig)
      include(BuiltinScalarDefinition)

      sig { override.params(result: Object).returns(Object) }
      def coerce_result(result:)
        if result == true || result == false
          result
        else
          raise "Value not a boolean"
        end
      end
    end
    private_constant(:BooleanClass)

    Boolean = BooleanClass.new

    class IDClass
      extend(T::Sig)
      include(BuiltinScalarDefinition)

      sig { override.params(result: Object).returns(Object) }
      def coerce_result(result:)
        if result.is_a?(::String) || result.is_a?(Integer)
          result
        else
          raise "Value not a string or integer"
        end
      end
    end
    private_constant(:IDClass)

    ID = IDClass.new
  end
end
