require "shale"

class Address < Shale::Mapper
  attribute :city, Shale::Type::String
  attribute :street, Shale::Type::String
  attribute :zip, Shale::Type::String
end
