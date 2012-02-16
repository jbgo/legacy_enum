module LegacyEnum
  module ClassMethods
    def legacy_enum(name, *options, &block)
      extracted_options = options.extract_options!
      id_attr_name = extracted_options[:lookup].try(:to_s) || "#{name.to_s.capitalize}ID"

      config = MethodDefinitionDSL.new
      config.instance_eval(&block)

      cattr_accessor :enum_config unless defined? self.enum_config
      self.enum_config ||= {}

      self.enum_config[name] = { values: config.enum_def, lookup: id_attr_name }

      class_eval do

        define_method :legacy_value do |name|
          send enum_config[name][:lookup].to_sym
        end

        define_method name do
          self.enum_config[name][:values].valued(self.legacy_value(name)).try(:[], :name)
        end

        define_method "#{name}=" do |value|
          self.send("#{id_attr_name}=".to_sym, nil) if value.blank?
          enum_entry = self.enum_config[name][:values].named(value)
          unless enum_entry.blank?
            self.send("#{id_attr_name}=".to_sym, enum_entry[:value])
          end
        end

        define_method "#{name}_label" do
          self.enum_config[name][:values].valued(self.legacy_value(name)).try(:[], :label)
        end

        return unless extracted_options[:scope]
        
        scope name.to_sym, 
          lambda { |enum_value| where(id_attr_name => self.enum_config[name][:values].named(enum_value)[:value] ) }
        
        self.enum_config[name][:values].each do |config|
          singleton_class.instance_eval do
            if extracted_options[:scope] == :one
              define_method config[:name].to_sym, lambda { send(name, config[:name]).first }
            else
              define_method config[:name].to_sym, lambda { send(name, config[:name]) }
            end
          end
        end
        
      end

    end

    # Returns all enumerations for the class by enum_name and then name => value
    def enums
      inject_block(:name, :value)
    end

    # Returns all enumerations for the class by enum_name and then name => label
    def labels
      inject_block(:name, :label)
    end

    # Returns all enumerations for the class by enum_name and then value => name
    def enum_ids
      inject_block(:value, :name)
    end

  private
    # Restructures the enum_config around a key/value pair
    def inject_block(key, value)
      self.enum_config.inject({}) do |acc, (name,config)|
        acc.merge( { name => config[:values].inject({}) do |inner_acc, enum_item|
          inner_acc.merge( { enum_item[key] => enum_item[value] } )
        end })
      end
    end
  end
end