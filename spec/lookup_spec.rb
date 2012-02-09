require 'spec_helper'

class LookupTest < SpecModel
  attr_accessor :foo_id, :BarID
  legacy_enum :foo, lookup: :foo_id do |e|
    e.first 1
  end

  legacy_enum :bar do |e|
    e.first 1
  end
end

describe 'Lookup' do

  it 'changes the underlying lookup field' do
    test = LookupTest.new

    test.foo_id.should == nil

    test.foo = :first
    test.foo_id.should == 1
  end

  it 'reflects changes in the underlying lookup field' do
    test = LookupTest.new
    
    test.foo.should == nil

    test.foo_id = 1
    test.foo.should == :first
  end

  it "defaults to postfixing 'ID' on the capitalized enum name if no lookup is given" do
    test = LookupTest.new

    test.BarID.should == nil

    test.bar = :first
    test.BarID.should == 1
  end
end