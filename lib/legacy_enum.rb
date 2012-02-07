require 'active_record'

require 'legacy_enum/method_definition_dsl'
require 'legacy_enum/class_methods'

ActiveRecord::Base.extend LegacyEnum::ClassMethods