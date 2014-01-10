require 'spec_helper'

class ValuesTest < SpecModel
  attr_accessor :int_column, :string_column, :symbol_column

  legacy_enum :ints, lookup: :int_column do |e|
    e.first 1
  end

  legacy_enum :strings, lookup: :string_column do |e|
    e.first "one"
  end
end

describe 'Values' do
  it "can be integers" do
    value = ValuesTest.new
    
    value.ints = :first
    value.int_column.should == 1
  end

  it "can be strings" do
    value = ValuesTest.new

    value.strings = :first
    value.string_column.should == "one"
  end

  it "matches string values case insensitively" do
    value = ValuesTest.new

    value.string_column = "ONe"
    value.strings.should == :first
  end

  it "are set to nil for invalid enumerated values" do
    value = ValuesTest.new

    value.ints = :doesnt_exist
    value.ints.should == nil
    value.int_column.should == nil
  end

  it "can be explicitly set to nil" do
    value = ValuesTest.new(ints: :first)

    value.ints = nil
    value.ints.should == nil
    value.int_column.should == nil
  end

  it 'can handle symbols' do
    value = ValuesTest.new
    value.ints = 'first'
    value.int_column.should == 1
  end
end
