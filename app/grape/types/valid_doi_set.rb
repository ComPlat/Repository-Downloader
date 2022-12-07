module Types
  class ValidDoiSet
    attr_reader :value
    def initialize(value)= @value = value

    def self.parse(value)
      new value.split(",").compact.select { |doi| /\d\d(?:.)\d\d\d\d\d(?:\/)*./.match?(doi) }.uniq
    end
  end
end
