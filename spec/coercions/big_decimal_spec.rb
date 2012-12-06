require 'spec_helper'
require 'bigdecimal'
require 'jruby-coercion/numeric'

describe Java::JavaMath::BigDecimal do 
  context "Numeric" do
    [
      [3, 3],
      [Integer(3), 3],
      [-100, -100],
      [0, 0]
    ].each do |test_numeric, constructor_arg|
      specify { test_numeric.to_java(described_class).should eq(described_class.new(constructor_arg)) }
    end
  end
end
