class DctElementMapper < ShaleCustom::Mapper
  attribute :conformsTo, DctListMapper

  json do
    map "http://purl.org/dc/terms/conformsTo", to: :conformsTo
  end
end
