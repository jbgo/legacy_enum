require 'bundler/setup'

require 'legacy_enum'
require 'test_model'
require 'spec_model'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
