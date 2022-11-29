module RootMappers
  class SampleMapper < ShaleCustom::Mapper
    attribute :context, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :dct_conformsTo, SampleMappers::DctElementMapper # TODO: Should be DctConformsToMapper
    attribute :id, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :url, Shale::Type::String
    attribute :identifier, Shale::Type::String
    attribute :iupacName, Shale::Type::String
    attribute :smiles, Shale::Type::String
    attribute :inChI, Shale::Type::String
    attribute :inChIKey, Shale::Type::String
    attribute :molecularFormula, Shale::Type::String
    attribute :meltingPoint, Shale::Type::String
    attribute :boilingPoint, Shale::Type::String
    attribute :molecularWeight, SampleMappers::MolecularWeightMapper
    attribute :analysisList, SampleMappers::AnalysisListMapper

    json do
      map "@context", to: :context
      map "@type", to: :type
      map "dct:conformsTo", to: :dct_conformsTo
      map "@id", to: :id
      map "name", to: :name
      map "url", to: :url
      map "identifier", to: :identifier
      map "iupacName", to: :iupacName
      map "smiles", to: :smiles
      map "inChI", to: :inChI
      map "inChIKey", to: :inChIKey
      map "molecularFormula", to: :molecularFormula
      map "meltingPoint", to: :meltingPoint
      map "boilingPoint", to: :boilingPoint
      map "molecularWeight", to: :molecularWeight
      map "analysisList", to: :analysisList
    end
  end
end
