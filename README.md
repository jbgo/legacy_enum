# LegacyEnum

Allows your Rails app to interact with C-style integer-backed enumeration db columns using a more Ruby-ish syntax. 

```ruby
class Employee < ActiveRecord::Base
  legacy_enum :payroll_type, lookup: :payroll_type_id do |e|
    e.salaried 1
    e.full_time 2
    e.part_time 3
  end
end

# You can use a symbol syntax for more readable code.
employee = Employee.new
employee.payroll_type = :salaried

# The database still sees the column as an integer
p employee.payroll_type_id 
# >> 1

# Labels are provided for humanized display of your enum values
p employee.payroll_type_label
# >> Salaried

# You can still address the column as a integer field (if you have to)
employee.payroll_type_id = 3
p employee.payroll_type
# >> :part_time
```

## Requires

* Rails > 3.0
* Ruby > 1.9

## Why?

Lots of legacy apps written in C/C++/C#/Java have integer columns in the database that represent enumerated values in the system. 

For example, in a legacy system dealing with employees, an employee might be classified with a C-style enumeration like: 

```c
enum PayrollType { Salaried = 1, FullTime, PartTime }
// stored in a db column named "payroll_type_id" as its integer value
```

This could be accessed using legacy_enum like so:

```ruby  
legacy_enum :payroll_type do |e|
  e.salaried 1
  e.full_time 2
  e.part_time 3
end
```

## Usage

```ruby
legacy_enum [rails_friendly_name], options do |e|
  e.enumerated_name value, [options]
  ...
end
```

## Options

#### Lookups

Conventionally, legacy_enum assumes that the backing int column is named the same as your field name, postfixed with "_id". If that isn't the case, use the "lookup" option.

```ruby
legacy_enum :payroll_type, lookup: :unconventional_id_column_name do |e|
  ...
end
```

#### Values

Legacy_enum requires that a backing value be provided for each enumerated name. A value can be an integer or a string.

```ruby
legacy_enum :int_values do |e|
  e.some_value 32
  e.another_value 64
end

legacy_enum :string_values do |e|
  e.a_string_value_is_ok 'zip_zop_zoobity_bop'
  e.another_string 'here_i_go_down_the_slope'
end
```

#### Labels

Labels are automatically created and conventionally have the name [legacy_enum_field]_label. For instance, this definition would have a label named 'foo_label'

```ruby  
legacy_enum :foo do |e|
  e.some_value 1
end
```

Each enumerated name, by default, has a label that is just the ActiveSupport#Titleized version of the enum name. This can be overridden using the 'label' option for each value.

```ruby
legacy_enum :foo do |e|
  e.crazy_label 1 label: 'Roflcopter'
end

foo = :crazy_label
p foo_label
# >> 'Roflcopter'
```

#### Scopes

ActiveRecord scopes can be created for your enumerated field, although by default they are not. The 'scope' option supports two values, :many and :one. 'Many' creates a scope with the enumeration name that accepts symbol values for the scope. 

```ruby
class Employee < ActiveRecord::Base
  legacy_enum :payroll_type, scope: :many do |e|
    e.salaried 1
    e.full_time 2
    e.part_time 3
  end
end

# The following scopes are created
Employee.payroll_type(:salaried) 
# 'SELECT * FROM employees WHERE payroll_type_id = 1'
Employee.salaried
# 'SELECT * FROM employees WHERE payroll_type_id = 1'
Employee.full_time
# 'SELECT * FROM employees WHERE payroll_type_id = 2'
Employee.part_time
# 'SELECT * FROM employees WHERE payroll_type_id = 3'
```

## Who?
  
legacy_enum was written by [Sean Scally](http://github.com/anydiem) for [AutoRevo](http://www.autorevo.com) with code contributed by [Matt Shannon](http://github.com/dmshann0n). 

## License

Released under the MIT license:

* http://www.opensource.org/licenses/MIT