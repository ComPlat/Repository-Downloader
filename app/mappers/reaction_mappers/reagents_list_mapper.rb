module ReactionMappers
  class ReagentsListMapper < ShaleCustom::Mapper
    attribute :numberOfItems, Shale::Type::Integer
    attribute :itemListElement, ReagentsList::ItemListElementMapper, collection: true
  end
end
