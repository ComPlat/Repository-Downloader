module RootMappers
  class AnalysisMapper < ShaleCustom::Mapper
    attribute :context, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :ontologies, Shale::Type::String
    attribute :title, Shale::Type::String
    attribute :descriptions, ShaleCustom::Types::HashType
    attribute :url, Shale::Type::String
    attribute :identifier, Shale::Type::String
    attribute :datasetList, ::AnalysisMappers::DataSetListMapper

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

    csv do
      map "context", to: :context
      map "type", to: :type
      map "id", to: :id
      map "ontologies", to: :ontologies
      map "title", to: :title
      map "descriptions", using: {from: :csv_from_descriptions, to: :descriptions_to_csv}
      map "url", to: :url
      map "identifier", to: :identifier
      map "datasetList", to: :datasetList
    end

    def descriptions_from_csv(model, value)
      model.descriptions = JSON.parse value.tr("'", "\"").tr(";", ",")
    end

    def descriptions_to_csv(model, doc)
      doc["descriptions"] = model.descriptions.nil? ? nil : model.descriptions.to_json.tr("\"", "'").tr(",", ";")
    end
  end
end
