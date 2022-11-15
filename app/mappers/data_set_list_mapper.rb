class DataSetListMapper < ShaleCustom::Mapper
  attribute :numberOfItems, Shale::Type::Integer
  attribute :itemListElement, DataSetItemListElementMapper, collection: true
end
