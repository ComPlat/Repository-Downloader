module Types
  class PositiveIntegerSet
    attr_reader :value
    def initialize(value)= @value = value

    def self.parse(value)
      array_of_strings = value.split(",")
      return Grape::Types::InvalidValue.new("No empty values allowed.") if array_of_strings.any? { |str| str.blank? }
      return Grape::Types::InvalidValue.new("No empty list allowed.") if array_of_strings.empty?

      array_of_numbers = array_of_strings.map { |string| string.to_i }
      return Grape::Types::InvalidValue.new("No none-positive values allowed.") if array_of_numbers.none? { |str| str.positive? }
      return Grape::Types::InvalidValue.new("No duplicates in list allowed.") unless array_of_numbers.uniq.size == array_of_numbers.size

      new array_of_numbers
    end
  end
end
