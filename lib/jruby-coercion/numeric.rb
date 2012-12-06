require 'jruby-coercion'

class Numeric
  include ::Jruby::Coercion::Coercable
end

# java.math.BigDecimal
::Jruby::Coercion::Registry.register_converter(Numeric, java.math.BigDecimal) do |numeric, java_type|
  java_type.new(numeric)
end

::Jruby::Coercion::Registry.register_converter(Integer, java.math.BigDecimal) do |integer, java_type|
  java_type.new(integer)
end

::Jruby::Coercion::Registry.register_converter(Fixnum, java.math.BigDecimal) do |fixnum, java_type|
  java_type.new(fixnum)
end

# java.math.BigInteger
::Jruby::Coercion::Registry.register_converter(Numeric, java.math.BigInteger) do |numeric, java_type|
  java_type.new("#{numeric}")
end

::Jruby::Coercion::Registry.register_converter(Integer, java.math.BigInteger) do |integer, java_type|
  java_type.new("#{integer}")
end

::Jruby::Coercion::Registry.register_converter(Fixnum, java.math.BigInteger) do |fixnum, java_type|
  java_type.new("#{fixnum}")
end
