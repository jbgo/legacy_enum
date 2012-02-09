require 'spec_helper'

describe 'Scopes' do
  context 'using :many' do 
    it "are not created unless specified"
    it "creates a generic scope for the enumeration"
    it "creates a scope for each enumerated value"
  end
  context 'using :one' do
    it 'assumes there is one and only one enumerated item'
  end
end