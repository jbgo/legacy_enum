module LegacyEnum
  class MethodDefinitionDSL
    attr_accessor :enum_def

    def method_missing(symbol, *args)
      @enum_def ||= []
      @enum_def.singleton_class.send :include, ConfigurationSearch
      
      options = args.extract_options!
      
      options.merge! name: symbol
      options.merge! value: args[0] unless args.empty?
      options.merge! label: symbol.to_s.titleize unless options.keys.include?(:label) 
      
      @enum_def << options  
    end
  end
end