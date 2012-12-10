require 'jruby_coercion/registry'

module ::JrubyCoercion::RubyToJava

  class Registry < ::JrubyCoercion::Registry

    DEFAULT_CONVERTER = lambda { |val| val.jruby_default_to_java }

    ##
    # Override for new_registry_entry_for_type in RubyToJava
    # that calls jruby default to_java when nil is the to_type
    #
    def self.new_registry_entry_for_type(from_type)
      new_type_registry = Java::JavaUtilConcurrent::ConcurrentHashMap.new
      new_type_registry[::JrubyCoercion::Registry::DEFAULT_KEY] = DEFAULT_CONVERTER

      return new_type_registry
    end
  end

end
