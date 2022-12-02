module AnalysisMappers::DataSetList::ItemListElement::AttachmentList
  class ItemListElementMapper < ShaleCustom::Mapper
    attribute :type, Shale::Type::String
    attribute :identifier, Shale::Type::String
    attribute :filename, Shale::Type::String
    attribute :filepath, Shale::Type::String

    json do
      map "@type", to: :type
      map "identifier", to: :identifier
      map "filename", to: :filename
      map "filepath", to: :filepath
    end
  end
end
