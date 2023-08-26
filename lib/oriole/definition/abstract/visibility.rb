# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    module Abstract
      module Visibility
        extend(T::Sig)
        extend(T::Helpers)

        abstract!

        sig { abstract.params(context: Object).returns(T::Boolean) }
        def visible?(context:); end
      end
    end
  end
end
