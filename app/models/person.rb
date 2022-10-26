require "shale"
require "shale/adapter/nokogiri"
require "shale/adapter/csv"
Shale.xml_adapter = Shale::Adapter::Nokogiri
Shale.csv_adapter = Shale::Adapter::CSV

class Person < Shale::Mapper
  attribute :first_name, Shale::Type::String
  attribute :last_name, Shale::Type::String
  attribute :age, Shale::Type::Integer
  attribute :married, Shale::Type::Boolean, default: -> { false }
  attribute :hobbies, Shale::Type::String, collection: true
  attribute :address, Address
end
