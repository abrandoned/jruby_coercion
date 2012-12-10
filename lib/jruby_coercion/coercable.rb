require 'jruby_coercion/ruby_to_java/registry'

module JrubyCoercion
  module Coercable

    def self.included(klass)
      unless klass.method_defined?(:jruby_default_to_java)
        klass.class_eval do 
          alias_method :jruby_default_to_java, :to_java

          def to_java(java_type = nil)
            converter = ::JrubyCoercion::RubyToJava::Registry.registry_converts_class_and_to?(self.class, java_type)

            if converter
              return converter.call(self)
            else
              jruby_default_to_java(java_type)
            end
          end


          def coerce_to?(java_type)
            return ::JrubyCoercion::RubyToJava::Registry.registry_converts_class_and_to?(self.class, java_type)
          end
          alias_method :coerced_to?, :coerce_to?

        end
      end
    end

  end
end
