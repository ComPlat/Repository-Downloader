class AnalysisPublicationMapper < ShaleCustom::Mapper
  model Publication

  attribute :@context, Shale::Type::String
  attribute :@type, Shale::Type::String
  attribute :@id, Shale::Type::String
  attribute :ontologies, Shale::Type::String
  attribute :title, Shale::Type::String
  attribute :descriptions, Shale::Type::String
  attribute :url, Shale::Type::String
  attribute :identifier, Shale::Type::String
  attribute :datasetList, DataSetListMapper
end
