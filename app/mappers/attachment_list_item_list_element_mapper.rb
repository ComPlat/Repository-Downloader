class AttachmentListItemListElementMapper < ShaleCustom::Mapper
  attribute :type, Shale::Type::String
  attribute :identifier, Shale::Type::String
  attribute :filename, Shale::Type::String
  attribute :filepath, Shale::Type::String
  # attribute :attachmentList, AttachmentListMapper, collection: true
end
