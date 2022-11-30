module ReactionMappers::ReagentsList
  class ItemListElementMapper < ShaleCustom::Mapper
    attribute :type, Shale::Type::String
    attribute :dct_conformsTo, ReactionMappers::ReagentsList::ItemListElement::DctListMapper
    attribute :id, Shale::Type::String
    attribute :identifier, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :molecularFormula, Shale::Type::String
    attribute :inChIKey, Shale::Type::String
    attribute :smiles, Shale::Type::String

    json do
      map "@type", to: :type
      map "dct:conformsTo", to: :dct_conformsTo
      map "@id", to: :id
      map "identifier", to: :identifier
      map "name", to: :name
      map "molecularFormula", to: :molecularFormula
      map "inChIKey", to: :inChIKey
      map "smiles", to: :smiles
    end
  end
end
