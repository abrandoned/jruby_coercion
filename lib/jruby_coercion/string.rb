require 'jruby_coercion'
require 'jruby_coercion/coercable'
require 'jruby_coercion/ruby_to_java/registry'

class String
  include ::JrubyCoercion::Coercable
end

# java.math.BigDecimal
::JrubyCoercion::RubyToJava::Registry.register_converter(String, java.math.BigDecimal) do |string|
  java.math.BigDecimal.new(string)
end

# java.math.BigInteger
::JrubyCoercion::RubyToJava::Registry.register_converter(String, java.math.BigInteger) do |string|
  java.math.BigInteger.new(string)
end
