require "jruby-coercion/version"
require 'thread'
require "java"

module Jruby
  module Coercion

    module Coercable
      def to_java(java_type = nil)
        return super if java_type.nil?
        converter = ::Jruby::Coercion::Registry.registry_converts_class_and_to?(self.class, java_type)

        if converter
          return converter.call(self, java_type)
        else
          super
        end
      end
    end

    class Registry
      class << self
        attr_reader :converter_registry
      end

      @converter_registry ||= Java::JavaUtilConcurrent::ConcurrentHashMap.new

      def self.register_converter(ruby_type, java_type, callable = nil, &blk)
        Thread.exclusive do 
          callable ||= blk
          ruby_type_converter = (@converter_registry[ruby_type] ||= 
                                 ::Java::JavaUtilConcurrent::ConcurrentHashMap.new)

          ruby_type_converter[java_type] = callable
          @converter_registry[ruby_type] = ruby_type_converter
        end
      end

      def self.registry_converts_class?(ruby_type)
        if !ruby_type.nil? && (class_level = converter_registry[ruby_type])
          return class_level
        else
          false
        end
      end

      def self.registry_converts_class_and_to?(ruby_type, java_type)
        if (!java_type.nil? && 
            (class_level = registry_converts_class?(ruby_type)) &&
            (converter = class_level[java_type]))

          return converter
        else
          false
        end
      end

    end
  end
end

require 'jruby-coercion/numeric'
