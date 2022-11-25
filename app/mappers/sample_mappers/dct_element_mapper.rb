module SampleMappers
  class DctElementMapper < ShaleCustom::Mapper
    attribute :dct_conformsTo, ReactionMappers::DctListMapper

    json do
      map "http://purl.org/dc/terms/conformsTo", to: :dct_conformsTo
    end
  end
end
