module LegacyEnum
  module ConfigurationSearch
    def named(name)
      find { |config| config[:name] == name }
    end

    def valued(value)
      search_value = value.to_s.upcase
      find { |config| config[:value].to_s.upcase === search_value }
    end

    def labelled(label)
      find { |config| config[:label] == label }
    end
  end
end