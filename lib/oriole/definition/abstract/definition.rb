# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    module Abstract
      module Definition
        extend(T::Sig)
        extend(T::Helpers)

        abstract!

        sig { abstract.returns(String) }
        def graphql_name; end

        sig { abstract.returns(T.nilable(String)) }
        def description; end
      end
    end
  end
end
