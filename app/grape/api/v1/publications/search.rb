class API::V1::Publications::Search < Grape::API
  version "v1", using: :path

  namespace "/publications/search" do
    desc "Search publications via authors and/or contributor and/or description", produces: %w[application/json application/xml text/csv]
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
      PublicationsBySearchPresenter.new(params).publications
    end
  end

  route(:any, "*path") { error!("Not found", 404) }
end
