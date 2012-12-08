require "jruby-coercion/version"
require 'thread'
require "java"

module Jruby
  module Coercion

    def self.native_type?(java_type)
      java_type.class == Java::JavaClass
    end

    def self.ruby_type?(java_type)
      java_type.class == Class
    end

    def self.alternative_class(java_type)
      if native_type?(java_type)
        return java_type.ruby_class
      else
        return java_type.java_class
      end
    end

    module Coercable
      def to_java(java_type = nil)
        return super if java_type.nil?
        converter = ::Jruby::Coercion::Registry.registry_converts_class_and_to?(self.class, java_type)

        if converter
          return converter.call(self)
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
          # Register alternative type java_class/ruby_class
          ruby_type_converter[::Jruby::Coercion.alternative_class(java_type)] = callable 

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
