module LegacyEnum
  module ConfigurationSearch
    def named(name)
      find { |config| config[:name] == name } || null_definition
    end

    def valued(value)
      search_value = value.to_s.upcase
      find { |config| config[:value].to_s.upcase === search_value } || null_definition
    end

    def labelled(label)
      find { |config| config[:label] == label } || null_definition
    end

    private
      def null_definition
        { name: nil, value: nil, label: nil }
      end
  end
end