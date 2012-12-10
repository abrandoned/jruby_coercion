require 'thread'
require 'jruby_coercion'

class ::JrubyCoercion::Registry
  class << self
    attr_reader :converter_registry
  end

  DEFAULT_KEY = "JRUBY_COERCION_DEFAULT".freeze

  @converter_registry ||= Java::JavaUtilConcurrent::ConcurrentHashMap.new

  ##
  # Class Methods
  #
  def self.alternative_class(java_type)
    if ::JrubyCoercion.native_type?(java_type)
      return java_type.ruby_class
    else
      return java_type.java_class
    end
  end

  def self.new_registry_entry_for_type(from_type)
    raise "new_registry_entry_for_type must be overridden in child classes"
  end

  def self.register_converter(from_type, to_type, callable = nil, &blk)
    Thread.exclusive do 
      callable ||= blk
      to_type ||= DEFAULT_KEY

      from_type_converter = (@converter_registry[from_type] ||= new_registry_entry_for_type(from_type))

      from_type_converter[to_type] = callable
      # Register alternative type java_class/ruby_class
      from_type_converter[self.alternative_class(to_type)] = callable unless to_type == DEFAULT_KEY

      @converter_registry[from_type] = from_type_converter
    end
  end

  def self.registry_converts_class?(convert_type)
    if !convert_type.nil? && (class_level = converter_registry[convert_type])
      return class_level
    else
      false
    end
  end

  def self.registry_converts_class_and_to?(from_type, to_type)
    if (class_level = registry_converts_class?(from_type))
      return ::JrubyCoercion::Converter.new(class_level[to_type])
    else
      return ::JrubyCoercion::Converter.new(false)
    end
  end

  ##
  # Class Aliases
  #
  class << self
    alias_method :register_conversion, :register_converter
    alias_method :register_coercion, :register_converter
    alias_method :registry_converts_type?, :registry_converts_class?
    alias_method :registry_converts_type_and_to?, :registry_converts_class_and_to?
    alias_method :registry_for_type_and_to, :registry_converts_type_and_to?
  end

end
