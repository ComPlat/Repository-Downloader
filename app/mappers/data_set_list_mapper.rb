class DataSetListMapper < ShaleCustom::Mapper
  attribute :numberOfItems, Shale::Type::Integer
  attribute :itemListElement, DataSetListItemListElementMapper, collection: true
end
