# typed: strict
# frozen_string_literal: true

module Oriole
  module Execution
    module CoerceResult
      extend(T::Sig)
      extend(T::Helpers)

      abstract!

      sig { abstract.params(result: Object).returns(Object) }
      def coerce_result(result:); end
    end
  end
end
