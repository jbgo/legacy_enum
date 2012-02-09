require 'spec_helper'

class MetadataTest < SpecModel
  attr_accessor :foo_id, :bar_id, :baz_id

  legacy_enum :foo, lookup: :foo_id do |e|
    e.one 1
  end

  legacy_enum :bar, lookup: :boo_id do |e|
    e.uno 1
  end

  legacy_enum :baz, lookup: :baz_id do |e|
    e.eins 1
  end
end

describe 'A class with legacy_enum' do
  it 'can have all enums accessed by name' do 
    MetadataTest.enums.count.should == 3
    MetadataTest.enums[:foo][:one].should == 1
  end

  it 'can have all enums grouped by value' do 
    MetadataTest.enum_ids.count.should == 3
    MetadataTest.enum_ids[:foo][1].should == :one
  end

  it 'can have their labels grouped by enum' do 
    MetadataTest.labels.count.should == 3
    MetadataTest.labels[:foo][:one].should == 'One'
  end
end