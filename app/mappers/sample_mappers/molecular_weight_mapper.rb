module SampleMappers
  class MolecularWeightMapper < ShaleCustom::Mapper
    attribute :value, Shale::Type::Float

    json do
      map "value", to: :value
    end
  end
end
