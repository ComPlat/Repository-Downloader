module Types
  class ValidListOfSearchOperators
    attr_reader :value

    def initialize(value) = @value = value

    def self.parse(value)
      array_of_strings = value.split("|")

      return Grape::Types::InvalidValue.new("No empty values allowed.") if array_of_strings.size == 0

      return Grape::Types::InvalidValue.new("No empty values allowed.") if array_of_strings.any? { |str| str.blank? }

      return Grape::Types::InvalidValue.new("Only allowed values are 'EQUAL' and 'LIKE'") if
        array_of_strings.any? { |str| str != "EQUAL" && str != "LIKE" }

      new array_of_strings
    end
  end
end
