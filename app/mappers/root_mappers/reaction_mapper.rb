module RootMappers
  class ReactionMapper < ShaleCustom::Mapper
    attribute :context, Shale::Type::String
    attribute :id, Shale::Type::String
    attribute :type, Shale::Type::String
    attribute :name, Shale::Type::String
    attribute :identifier, Shale::Type::String
    attribute :status, Shale::Type::String
    attribute :description, Shale::Type::String
    attribute :temperature, Shale::Type::String
    attribute :reaction_type, Shale::Type::String
    attribute :duration, Shale::Type::String
    attribute :purification, Shale::Type::String
    attribute :reagents_list, ReactionMappers::ReagentsListMapper

    json do
      map "@context", to: :context
      map "@id", to: :id
      map "@type", to: :type
      map "name", to: :name
      map "identifier", to: :identifier
      map "status", to: :status
      map "description", to: :description
      map "temperature", to: :temperature
      map "reactionType", to: :reaction_type
      map "duration", to: :duration
      map "purification", to: :purification
      map "reagentsList", to: :reagents_list
    end

    csv do
      map "context", to: :context
      map "id", to: :id
      map "type", to: :type
      map "name", to: :name
      map "identifier", to: :identifier
      map "status", to: :status
      map "description", to: :description
      map "temperature", to: :temperature
      map "reactionType", to: :reaction_type
      map "duration", to: :duration
      map "purification", to: :purification
      map "reagentsList", to: :reagents_list
    end
  end
end
