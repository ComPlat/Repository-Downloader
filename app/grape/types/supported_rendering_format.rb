module Types
  class SupportedRenderingFormat
    attr_reader :value
    def initialize(value)= @value = value

    def self.parse(value)
      new value.to_s
    end
  end
end
