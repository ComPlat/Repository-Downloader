module SampleMappers
  class DctConformsToMapper < ShaleCustom::Mapper
    attribute :dct_conformsTo, ReactionMappers::ReagentsList::ItemListElement::DctConformsToElementMapper

    json do
      map "http://purl.org/dc/terms/conformsTo", to: :dct_conformsTo
    end
  end
end
