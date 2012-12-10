require "java"
require "jruby-coercion/version"
require "jruby-coercion/ruby_to_java_converter"

module Jruby
  module Coercion

    def self.native_type?(java_type)
      java_type.class == Java::JavaClass
    end

    def self.ruby_type?(java_type)
      java_type.class == Class
    end

  end
end

require 'jruby-coercion/numeric'
