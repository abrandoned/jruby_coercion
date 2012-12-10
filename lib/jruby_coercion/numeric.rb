require 'jruby_coercion'
require 'jruby_coercion/coercable'
require 'jruby_coercion/ruby_to_java/registry'

class Numeric
  include ::JrubyCoercion::Coercable
end

# java.math.BigDecimal
::JrubyCoercion::RubyToJava::Registry.register_converter(Numeric, java.math.BigDecimal) do |numeric|
  java.math.BigDecimal.new(numeric)
end

::JrubyCoercion::RubyToJava::Registry.register_converter(Integer, java.math.BigDecimal) do |integer|
  java.math.BigDecimal.new(integer)
end

::JrubyCoercion::RubyToJava::Registry.register_converter(Fixnum, java.math.BigDecimal) do |fixnum|
  java.math.BigDecimal.new(fixnum)
end

# java.math.BigInteger
::JrubyCoercion::RubyToJava::Registry.register_converter(Numeric, java.math.BigInteger) do |numeric|
  java.math.BigInteger.new("#{numeric}")
end

::JrubyCoercion::RubyToJava::Registry.register_converter(Integer, java.math.BigInteger) do |integer|
  java.math.BigInteger.new("#{integer}")
end

::JrubyCoercion::RubyToJava::Registry.register_converter(Fixnum, java.math.BigInteger) do |fixnum|
  java.math.BigInteger.new("#{fixnum}")
end
