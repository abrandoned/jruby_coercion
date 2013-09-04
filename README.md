# JrubyCoercion
An attempt to provide an interface for Ruby/Java coercion in JRuby that both standardizes a means of coercion between
types and provides the ability to be extensible by outside parties to register custom coercion methods.

[Inspiration - Jruby Coercion](https://www.engineyard.com/blog/2009/5-things-to-look-for-in-jruby-1-4/)

## Installation

Add this line to your application's Gemfile:

    gem 'jruby_coercion'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jruby_coercion

## Usage
First a coercion routine must be registered and then `to_java(DestinationType)` must be called to run the coercion 
routine at time of assignment, you can also check out `coerced_attr_writer` for automatic coercions when calling
java methods with Ruby objects.

Registering a coercion routing
```ruby
  ##
  # Desire is to coerce a String (Ruby) into BigDecimal (Java)
  #
  ::JrubyCoercion::RubyToJava::Register.register_converter(String, java.math.BigDecimal) do |string_arg|
    java.math.BigDecimal.new(string_arg)
  end


  "12.21".to_java(java.math.BigDecimal) # <Java::JavaMath::BigDecimal:0xe273376>
```

Individual library/type implementors can register additional coercion routines where as the default Ruby/Java
coercion routines are registered when the gem loads.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
