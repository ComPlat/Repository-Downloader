module ReactionMappers
  class DctListMapper < ShaleCustom::Mapper
    attribute :type, Shale::Type::String
    attribute :id, Shale::Type::String

    json do
      map "@type", to: :type
      map "@id", to: :id
    end
  end
end
