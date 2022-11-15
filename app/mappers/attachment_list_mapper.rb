class AttachmentListMapper < ShaleCustom::Mapper
  attribute :numberOfItems, Shale::Type::Integer
  attribute :itemListElement, AttachmentListItemListElementMapper, collection: true
end
