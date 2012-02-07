$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "legacy_enum/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "legacy_enum"
  s.version     = LegacyEnum::VERSION
  s.authors     = ["Sean Scally"]
  s.email       = ["sean.scally@gmail.com"]
  s.homepage    = "http://github.com/anydiem/legacy_enum"
  s.summary     = "Brings enumerated int columns into the 21st century"
  s.description = "Allows you to address enumerated integer columns as more sane and readable symbols"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency 'rails', '~> 3.2.1'

  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'rspec'
end
