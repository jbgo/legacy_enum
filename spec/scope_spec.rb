require 'spec_helper'

class ScopesTest < SpecModel
  attr_accessor :no_scoping_id, :pay_period_id

  legacy_enum :no_scoping, lookup: :no_scoping_id do |e|
    e.noscope 1
  end

  legacy_enum :pay_period, lookup: :pay_period_id, scope: :many do |e|
    e.weekly 1
    e.monthly 2
  end
end

describe 'Scopes' do
  context 'using :many' do 
    it "are not created unless specified" do
      ScopesTest.respond_to?(:no_scoping).should == false
    end

    it "creates a generic scope for the enumeration" do
      ScopesTest.respond_to?(:pay_period).should == true
      ScopesTest.pay_period(:weekly).to_sql.should =~ /\"pay_period_id\" = 1/i
    end

    it "creates a scope for each enumerated value" do
      ScopesTest.respond_to?(:weekly).should == true
      ScopesTest.weekly.to_sql.should =~ /\"pay_period_id\" = 1/i
    end
  end
end