module AnalysisMappers
  class DataSetListMapper < ShaleCustom::Mapper
    attribute :numberOfItems, Shale::Type::Integer
    attribute :itemListElement, DataSetList::ItemListElementMapper, collection: true
  end
end
