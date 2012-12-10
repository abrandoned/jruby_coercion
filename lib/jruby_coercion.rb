require "java"
require "jruby_coercion/version"
require "jruby_coercion/converter"

module JrubyCoercion

  def self.native_type?(java_type)
    java_type.class == Java::JavaClass
  end

  def self.ruby_type?(java_type)
    java_type.class == Class
  end

end

require 'jruby_coercion/numeric'
