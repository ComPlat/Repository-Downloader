class AttachmentListMapper < ShaleCustom::Mapper
  attribute :numberOfItems, Shale::Type::Integer
  # attribute :itemListElement, ItemListElementMapper, collection: true
end
