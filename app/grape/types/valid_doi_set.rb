module Types
  class ValidDoiSet
    attr_reader :value

    def initialize(value) = @value = value

    def self.parse(value)
      array_of_strings = value.split(",")

      return Grape::Types::InvalidValue.new("No empty values allowed.") if array_of_strings.any? { |str| str.blank? }

      return Grape::Types::InvalidValue.new("No empty list allowed.") if array_of_strings.empty?

      # HINT: DOIS always have the format of 10.y/* where y stands for four or more decimal numbers
      return Grape::Types::InvalidValue.new("Invalid DOI.") if array_of_strings.any? { |str| !/10.\d\d\d\d*(?:\d)(?:\/)*./.match?(str) }

      return Grape::Types::InvalidValue.new("No duplicates in list allowed.") unless array_of_strings.uniq.size == array_of_strings.size

      new array_of_strings
    end
  end
end
