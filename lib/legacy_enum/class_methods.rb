module LegacyEnum
  module ClassMethods
    def legacy_enum(name, *options, &block)
      extracted_options = options.extract_options!
      id_attr_name = extracted_options[:lookup].try(:to_s) || "#{name.to_s.capitalize}ID"

      config = MethodDefinitionDSL.new
      config.instance_eval(&block)

      cattr_accessor :enum_config unless defined? self.enum_config
      self.enum_config ||= {}
      self.enum_config[name] = config.enum_def

      class_eval do
        find_enum_entry = Proc.new do |_self, name, sym|
          enum_entry = _self.enum_config[name].find do |hash|
            attr_value = _self.send(id_attr_name.to_sym)
            attr_value.to_s.upcase == hash[:value].to_s.upcase
          end

          enum_entry[sym] unless enum_entry.blank?
        end

        define_method name do
          find_enum_entry.call self, name, :name
        end

        define_method "#{name}=" do |value|
          self.send("#{id_attr_name}=".to_sym, nil) if value.blank?
          enum_entry = self.enum_config[name].find { |hash| hash[:name] == (value.blank? ? value : value.to_sym) }
          unless enum_entry.blank?
            self.send("#{id_attr_name}=".to_sym, enum_entry[:value])
          end
        end

        define_method "#{name}_label" do
          find_enum_entry.call(self, name, :label)
        end

        return unless extracted_options[:scope]
        
        scope name.to_sym, 
          lambda { |enum_value| where(id_attr_name => enums[name.to_sym][enum_value]) }
        
        self.enums[name].keys.each do |value|
          (class << self; self; end).instance_eval do
            if extracted_options[:scope] == :one
              define_method value.to_sym, lambda { send(name.to_sym, value.to_sym).first }
            else
              define_method value.to_sym, lambda { send(name.to_sym, value.to_sym) }
            end
          end
        end
        
      end

    end

    def enums
      inject_block(:name, :value)
    end

    def labels
      inject_block(:name, :label)
    end

    def enum_ids
      inject_block(:value, :name)
    end

  private
    #this name sux, refactor it
    def inject_block(key, value)
      self.enum_config.inject({}) do |acc, (name,config)|
        acc.merge( { name => config.inject({}) do |inner_acc, enum_item|
          inner_acc.merge( { enum_item[key] => enum_item[value] } )
        end })
      end
    end
  end
end