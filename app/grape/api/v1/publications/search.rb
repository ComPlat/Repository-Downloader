class API::V1::Publications::Search < Grape::API
  version "v1", using: :path

  namespace "/publications/search" do
    desc "Get publications via ChemotionID(s) or DOI(s)", produces: %w[application/json application/xml text/csv application/zip]
    params do
      optional :authors,
        type: Array[String],
        coerce_with: ->(value) { value.split("|") },
        documentation: {collectionFormat: "pipes", param_type: "query"},
        desc: "List of Authors, separated by |, only finds exact matches by name"
      optional :contributor,
        type: String,
        documentation: {param_type: "query"},
        desc: "Single Contributor, only finds exact matches by name"
      optional :description,
        type: String,
        documentation: {param_type: "query"},
        desc: "Searches description for any occurrence of search term"
    end
    get do
      stream PublicationsBySearchPresenter.new(params)
    end
  end

  route(:any, "*path") { error!("Not found", 404) }
end
