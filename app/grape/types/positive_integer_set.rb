module Types
  class PositiveIntegerSet
    attr_reader :value
    def initialize(value)= @value = value

    def self.parse(value)
      # array_of_filled_strings =
      # Grape::Types::InvalidValue.new("Empty values not allowed") unless array_of_filled_strings.size.positive?
      # Grape::Types::InvalidValue.new("Duplicate values not allowed") unless array_of_filled_strings.uniq == array_of_filled_strings

      new value.split(",").compact.map { |filled_string| filled_string.to_i }.select { |num| num.positive? }.uniq
    end
  end
end
