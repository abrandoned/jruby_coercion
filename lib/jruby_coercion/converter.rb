require 'delegate'
require 'forwardable'

module JrubyCoercion

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
      [ self, @converter ]        
    end

    alias_method :coerce, :call
  end

end
