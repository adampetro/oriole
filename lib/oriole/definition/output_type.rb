# typed: strict
# frozen_string_literal: true

module Oriole
  module Definition
    module OutputType
      extend(T::Sig)
      extend(T::Helpers)

      class << self
        extend(T::Sig)

        sig { params(inner: BaseOutputType).returns(OutputType) }
        def named(inner) = Named.new(required: false, inner:)

        sig { params(inner: BaseOutputType).returns(OutputType) }
        def named!(inner) = Named.new(required: true, inner:)

        sig { params(inner: OutputType).returns(OutputType) }
        def list(inner) = List.new(required: false, inner:)

        sig { params(inner: OutputType).returns(OutputType) }
        def list!(inner) = List.new(required: true, inner:)
      end

      sealed!
      abstract!

      sig { abstract.returns(T::Boolean) }
      def required?; end

      sig { abstract.returns(T::Boolean) }
      def list?; end

      sig { abstract.returns(BaseOutputType) }
      def base; end

      sig { abstract.params(base: BaseOutputType).returns(T.self_type) }
      def with_base(base); end

      class List < T::Struct
        extend(T::Sig)
        include(OutputType)

        const(:required, T::Boolean)
        const(:inner, OutputType)

        alias_method(:required?, :required)

        sig { override.returns(T::Boolean) }
        def list? = true

        sig { override.returns(BaseOutputType) }
        def base = inner.base

        sig { override.params(base: BaseOutputType).returns(T.self_type) }
        def with_base(base) = List.new(required:, inner: inner.with_base(base))
      end

      class Named < T::Struct
        extend(T::Sig)
        include(OutputType)

        const(:required, T::Boolean)
        const(:inner, BaseOutputType)

        alias_method(:required?, :required)

        sig { override.returns(T::Boolean) }
        def list? = false

        alias_method(:base, :inner)

        sig { override.params(base: BaseOutputType).returns(T.self_type) }
        def with_base(base) = Named.new(required:, inner: base)
      end
    end
  end
end
