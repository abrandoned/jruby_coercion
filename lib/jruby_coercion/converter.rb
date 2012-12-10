require 'delegate'
require 'forwardable'

module Jruby
  module Coercion

    class Converter < SimpleDelegator
      extend Forwardable
      def_delegator :@converter, :call

      attr_reader :converter

      ##
      # Constructor
      #
      def initialize(converter)
        @converter = converter
        super(!!@converter)
      end

      ## 
      # Public Instance Methods
      #
      def to_ary
        [ !@converter.nil?, @converter ]        
      end

      alias_method :coerce, :call
    end

  end
end
