# require 'jruby_coercion/registry'
# 
# module ::JrubyCoercion::JavaToRuby
# 
#   class Registry < ::JrubyCoercion::Registry
# 
#     DEFAULT_CONVERTER = lambda { |val| val }
# 
#     ##
#     # Override for new_registry_entry_for_type in JavaToRuby
#     # that calls
#     #
#     def self.new_registry_entry_for_type(from_type)
#       new_type_registry = Java::JavaUtilConcurrent::ConcurrentHashMap.new
#       new_type_registry[::JrubyCoercion::Registry::DEFAULT_KEY] = DEFAULT_CONVERTER
# 
#       return new_type_registry
#     end
#   end
# 
# end
