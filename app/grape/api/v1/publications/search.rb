class API::V1::Publications::Search < Grape::API
  version "v1", using: :path

  namespace "/publications/search" do
    desc "Search publications via authors and/or contributor and/or description", produces: %w[application/json application/xml text/csv]
    params do
      optional :authors_value,
        type: Array[String],
        coerce_with: ->(value) { value.split("|") },
        documentation: {collectionFormat: "pipes", param_type: "query"},
        desc: "List of Authors, separated by |, only finds exact matches by name",
        default: "Author Name"
      given :authors_value do
        requires :authors_search_operator,
          type: Array,
          coerce_with: ->(value) { Types::ValidListOfSearchOperators.parse(value).value },
          documentation: {collectionFormat: "pipes", param_type: "query"},
          desc: "Must be either EQUAL or LIKE",
          default: "EQUAL"
      end
      optional :contributor_value,
        type: String,
        documentation: {param_type: "query"},
        desc: "Single Contributor, only finds matches by name"
      given :contributor_value do
        requires :contributor_search_operator,
          type: String,
          documentation: {param_type: "query"},
          values: %w[EQUAL LIKE]
      end
      optional :description_value,
        type: String,
        documentation: {param_type: "query"},
        desc: "Searches description for a single search term"
      given :description_value do
        requires :description_search_operator,
          type: String,
          documentation: {param_type: "query"},
          values: %w[EQUAL LIKE]
      end
    end
    get do
      if params[:authors_value].length != params[:authors_search_operator].length
        Grape::Types::InvalidValue.new("Length of author values does not match the search operators")
      else
        PublicationsBySearchPresenter.new(params).publications
      end
    end
  end

  route(:any, "*path") { error!("Not found", 404) }
end
