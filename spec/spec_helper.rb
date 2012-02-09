require 'bundler/setup'

require 'legacy_enum'
require 'spec_model'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: ':memory:'
