module JrubyCoercion
  module Coercable

    def self.included(klass)
      klass.class_eval do 
        alias_method :jruby_default_to_java, :to_java

        def to_java(java_type = nil)
          converter = ::JrubyCoercion::Registry.registry_converts_class_and_to?(self.class, java_type)

          if converter
            return converter.call(self)
          else
            jruby_default_to_java(java_type)
          end
        end
      end
    end

    def coerce_to?(java_type)
      return ::JrubyCoercion::Registry.registry_converts_class_and_to?(self.class, java_type)
    end

  end
end
