require 'bigdecimal'
require 'jruby_coercion/registry'
require "jruby_coercion/coercable"

module ::JrubyCoercion::RubyToJava

  class Registry < ::JrubyCoercion::Registry

    DEFAULT_CONVERTER = lambda { |val| val.jruby_default_to_java }

    # Setup a default type mapping to correctly respond to #coerce_to?
    # calls and register the default mapping
    DEFAULT_TYPE_MAP = {
      Fixnum => java.lang.Long,
      TrueClass => java.lang.Boolean,
      FalseClass => java.lang.Boolean,
      Float => java.lang.Double,
      BigDecimal => java.math.BigDecimal,
      String => java.lang.String
    }

    ##
    # Override for new_registry_entry_for_type in RubyToJava
    # that calls jruby default to_java when nil is the to_type
    #
    def self.new_registry_entry_for_type(from_type)
      new_type_registry = Java::JavaUtilConcurrent::ConcurrentHashMap.new
      new_type_registry[::JrubyCoercion::Registry::DEFAULT_KEY] = DEFAULT_CONVERTER
      
      if (mapped_to = DEFAULT_TYPE_MAP[from_type])
        new_type_registry[mapped_to] = DEFAULT_CONVERTER
      end

      # Class should include Coercable
      from_type.__send__(:include, ::JrubyCoercion::Coercable)

      return new_type_registry
    end
  end

end

# Setup default mappings for jruby
::JrubyCoercion::RubyToJava::Registry::DEFAULT_TYPE_MAP.each do |ruby_type, java_type|
  ::JrubyCoercion::RubyToJava::Registry.register_converter(ruby_type, 
                                                           java_type, 
                                                           ::JrubyCoercion::RubyToJava::Registry::DEFAULT_CONVERTER)
end
