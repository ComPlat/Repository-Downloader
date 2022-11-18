module SampleMappers
  class DctElementMapper < ShaleCustom::Mapper
    attribute :conformsTo, ReactionMappers::DctListMapper

    json do
      map "http://purl.org/dc/terms/conformsTo", to: :conformsTo
    end
  end
end
