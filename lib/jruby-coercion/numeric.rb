require 'jruby-coercion'

class Numeric
  include ::Jruby::Coercion::Coercable
end

# java.math.BigDecimal
::Jruby::Coercion::Registry.register_converter(Numeric, java.math.BigDecimal) do |numeric|
  java.math.BigDecimal.new(numeric)
end

::Jruby::Coercion::Registry.register_converter(Integer, java.math.BigDecimal) do |integer|
  java.math.BigDecimal.new(integer)
end

::Jruby::Coercion::Registry.register_converter(Fixnum, java.math.BigDecimal) do |fixnum|
  java.math.BigDecimal.new(fixnum)
end

# java.math.BigInteger
::Jruby::Coercion::Registry.register_converter(Numeric, java.math.BigInteger) do |numeric|
  java.math.BigInteger.new("#{numeric}")
end

::Jruby::Coercion::Registry.register_converter(Integer, java.math.BigInteger) do |integer|
  java.math.BigInteger.new("#{integer}")
end

::Jruby::Coercion::Registry.register_converter(Fixnum, java.math.BigInteger) do |fixnum|
  java.math.BigInteger.new("#{fixnum}")
end
