require 'spec_helper'

class LookupTest < SpecModel
  attr_accessor :foo_id
  legacy_enum :foo, lookup: :foo_id do |e|
    e.first 1
  end
end

describe 'Lookup' do

  it 'changes the underlying lookup field' do
    test = LookupTest.new
    test.foo = nil
    test.foo_id.should == nil

    test.foo = :first
    test.foo_id.should == 1
  end
end