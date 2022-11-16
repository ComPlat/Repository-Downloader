class AnalysisListMapper
  attribute :numberOfItems, Shale::Type::Integer
  attribute :itemListElement, AnalysisListItemListElementMapper, collection: true
end
