class PersonMapper < ShaleCustom::Mapper
  attribute :first_name, Shale::Type::String
  attribute :last_name, Shale::Type::String
  attribute :age, Shale::Type::Integer
  attribute :married, Shale::Type::Boolean, default: -> { false }
  attribute :hobbies, Shale::Type::String, collection: true
  attribute :address, AddressMapper
end
