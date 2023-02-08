module Types
  class ValidListOfSearchOperators
    ALLOWED_SEARCH_OPERATORS = %w[EQUAL LIKE].freeze

    attr_reader :value

    def initialize(value) = @value = value

    def self.parse(value)
      return Grape::Types::InvalidValue.new("No empty input allowed.") if value.blank?

      array_of_strings = value.split("\t")

      return Grape::Types::InvalidValue.new("No empty list allowed.") if array_of_strings.empty?

      return Grape::Types::InvalidValue.new("No empty values allowed.") if array_of_strings.any? { |str| str == "" }

      # HINT: https://apidock.com/ruby/v2_6_3/Array/include%3F
      return Grape::Types::InvalidValue.new("Only allowed values are 'EQUAL' and 'LIKE'") unless
        ALLOWED_SEARCH_OPERATORS.to_set.superset? array_of_strings.to_set

      new array_of_strings
    end
  end
end
