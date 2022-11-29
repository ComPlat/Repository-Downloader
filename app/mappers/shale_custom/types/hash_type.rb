module ShaleCustom::Types
  class HashType < Shale::Type::Value
    def self.cast(value)
      value.nil? ? nil : value.as_json
    end
  end
end
