module AnalysisMapper::DataSetList::ItemListElement
  class AttachmentListMapper < ShaleCustom::Mapper
    attribute :numberOfItems, Shale::Type::Integer
    attribute :itemListElement, AttachmentList::ItemListElementMapper, collection: true
  end
end
