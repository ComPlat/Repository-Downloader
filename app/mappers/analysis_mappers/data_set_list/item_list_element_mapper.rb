module AnalysisMappers::DataSetList
  class ItemListElementMapper < ShaleCustom::Mapper
    attribute :type, Shale::Type::String
    attribute :identifier, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :Instrument, Shale::Type::String
    attribute :descriptions, Shale::Type::String
    attribute :attachmentList, ItemListElement::AttachmentListMapper

    json do
      map "@type", to: :type
      map "identifier", to: :identifier
      map "name", to: :name
      map "Instrument", to: :Instrument
      map "descriptions", to: :descriptions
      map "attachmentList", to: :attachmentList
    end
  end
end
