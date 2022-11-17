class AnalysisListMapper < ShaleCustom::Mapper
  attribute :numberOfItems, Shale::Type::Integer
  attribute :itemListElement, AnalysisMapper, collection: true
end
