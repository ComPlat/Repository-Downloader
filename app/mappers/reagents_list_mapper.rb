class ReagentsListMapper < ShaleCustom::Mapper
  attribute :numberOfItems, Shale::Type::Integer
  attribute :itemListElement, ReagentsListItemListElementMapper, collection: true
end
