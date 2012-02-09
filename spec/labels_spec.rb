require 'spec_helper'

class LabelsTest < SpecModel
  attr_accessor :payroll_type_id

  legacy_enum :payroll_type, lookup: :payroll_type_id do |e|
    e.part_time 1, label: 'Part-Timer'
    e.full_time 2
  end
end

describe 'Labels' do
  it 'default to blank' do
    test = LabelsTest.new
    test.payroll_type_label.should == nil
  end

  it 'can be specific' do
    test = LabelsTest.new(payroll_type: :part_time)
    test.payroll_type_label.should == 'Part-Timer'
  end

  it 'automatically labels with titleization if no label is provided' do
    test = LabelsTest.new(payroll_type: :full_time)
    test.payroll_type_label.should == 'Full Time'
  end
end