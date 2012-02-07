require 'spec_helper'

describe TestModel do
  it 'should translate Enumerated ID columns into enumerations' do
    TestModel.new(:EnumeratedColumnID => 1).enumerated.should == :first
  end
  
  it 'should translate enumerations back into Enumerated ID columns' do
    TestModel.new(:enumerated => :first).EnumeratedColumnID.should == 1
  end
  
  it 'should match int columns labels' do
    TestModel.new(:enumerated => :first).enumerated_label.should == "FIRST"
  end
  
  it 'should quietly reject invalid enumeration values' do
    TestModel.new(:enumerated => :doesnt_exist).enumerated.should be_nil
  end
  
  it 'should match int enumeration values to string column ids' do
    TestModel.new(:EnumeratedColumnID => '1').enumerated.should == :first
  end
  
  it 'should match string column ids to int enumeration values' do
    TestModel.new(:string_enumerated => :second).StringEnumeratedColumnID.should == "2"
  end
  
  it "should match string column labels" do
    TestModel.new(:string_enumerated => :second).string_enumerated_label.should == "SECOND"
  end
  
  it "should allow to be set to nil" do
    TestModel.new(:enumerated => nil).enumerated.should be_nil
  end
  
  it 'should match string enums case insensitively' do
    TestModel.new(:TestCasing => 'Pickup TRUCK').string_casing_enumerated.should == :pickup_truck
  end
end
