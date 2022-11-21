module SampleMappers
  class AnalysisListMapper < ShaleCustom::Mapper
    attribute :numberOfItems, Shale::Type::Integer
    attribute :itemListElement, RootMappers::AnalysisMapper, collection: true
  end
end
