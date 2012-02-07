class TestModel < ActiveRecord::Base
  def self.columns
    @columns ||= [];
  end

  legacy_enum :enumerated, :lookup => :EnumeratedColumnID do |e|
    e.first 1, :label => "FIRST"
    e.second 2, :label => "SECOND"
  end
  
  legacy_enum :string_enumerated, :lookup => :StringEnumeratedColumnID do |e|
    e.first "1", :label => "FIRST"
    e.second "2", :label => "SECOND"
  end

  legacy_enum :string_casing_enumerated, :lookup => :TestCasing do |e|
    e.pickup_truck 'Pickup truck'
  end

  legacy_enum :unlabelled, lookup: 'Unlabelled' do |e|
    e.unlabelled 1
  end
  
  attr_accessor :EnumeratedColumnID, :StringEnumeratedColumnID, :TestCasing, :Unlabelled
end