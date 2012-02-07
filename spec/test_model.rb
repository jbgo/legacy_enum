class TestModel < ActiveRecord::Base
  def self.columns
      @columns ||= [];
    end

  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default,
      sql_type.to_s, null)
  end

  # Override the save method to prevent exceptions.
  def save(validate = true)
    validate ? valid? : true
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
  
  attr_accessor :EnumeratedColumnID, :StringEnumeratedColumnID, :TestCasing
end