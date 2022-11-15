class AnalysisMapper < ShaleCustom::Mapper
  attribute :context, Shale::Type::String
  attribute :type, Shale::Type::String
  attribute :id, Shale::Type::String
  attribute :ontologies, Shale::Type::String
  attribute :title, Shale::Type::String
  attribute :descriptions, Shale::Type::String
  attribute :url, Shale::Type::String
  attribute :identifier, Shale::Type::String
  attribute :datasetList, DataSetListMapper

  json do
    map "@context", to: :context
    map "@type", to: :type
    map "@id", to: :id
    map "ontologies", to: :ontologies
    map "title", to: :title
    map "descriptions", to: :descriptions
    map "url", to: :url
    map "identifier", to: :identifier
    map "datasetList", to: :datasetList
  end
end
