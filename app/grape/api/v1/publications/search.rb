class API::V1::Publications::Search < Grape::API
  version "v1", using: :path

  namespace "/publications/search" do
    desc "Search publications via authors and/or contributor and/or description", produces: %w[application/json application/xml text/csv]
    params do
      optional :authors_value,
        type: Array[String],
        coerce_with: ->(value) { value.split("\t") if value.present? },
        documentation: {collectionFormat: "tsv", param_type: "query"}, # HINT: No pipes because RFC2396 reserves them for designating alternatives
        desc: "List of Authors, only finds exact matches by name"
      optional :authors_search_operator,
        type: Array[String],
        coerce_with: ->(value) { Types::ValidListOfSearchOperators.parse(value).value },
        documentation: {collectionFormat: "tsv", param_type: "query"},
        desc: "Must be either EQUAL or LIKE"
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
      if (params[:authors_value].blank? && params[:authors_search_operator].blank?) || (params[:authors_value].length == params[:authors_search_operator].length)
        PublicationsBySearchPresenter.new(params).publications
      else
        status :bad_request
        if params[:format] == "csv"
          ["authors_value and authors_search_operator must have the same length"]
        else
          {message: "authors_value and authors_search_operator must have the same length"}
        end
      end
    end
  end

  route(:any, "*path") { error!("Not found", 404) }
end
