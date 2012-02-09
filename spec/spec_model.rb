class SpecModel < ActiveRecord::Base
  def self.columns
    @columns ||= [];
  end
end