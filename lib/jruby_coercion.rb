require "java"
require "jruby_coercion/version"
require "jruby_coercion/converter"
require "jruby_coercion/coercable"

module JrubyCoercion

  def self.native_type?(java_type)
    java_type.class == Java::JavaClass
  end

  def self.ruby_type?(java_type)
    java_type.class == Class
  end

end

require "jruby_coercion/ruby_to_java/registry"
require "jruby_coercion/numeric"
require "jruby_coercion/string"
