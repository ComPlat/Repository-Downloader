class API::V1::Publications < Grape::API
  version "v1", using: :path

  namespace "/publications" do
    desc "Get publications via ChemotionID(s) or DOI(s)", produces: %w[application/json application/xml text/csv application/zip]

    params do
      optional :dois,
        type: Array[String],
        coerce_with: ->(value) { Types::ValidDoiSet.parse(value).value },
        documentation: {collectionFormat: "csv", param_type: "query"},
        desc: "List of DOIs, separated by comma, either this or chemotion_ids needs to be given"
      optional :chemotion_ids,
        type: Array[Integer],
        coerce_with: ->(value) { Types::PositiveIntegerSet.parse(value).value },
        documentation: {collectionFormat: "csv", param_type: "query"},
        desc: "List of Chemotion IDs, separated by comma, either this or dois needs to be given"
      exactly_one_of :chemotion_ids, :dois
    end

    get do


      case params
      in {chemotion_ids: Array}
        stream PublicationsByChemotionIdPresenter.new(params[:chemotion_ids]).public_send("to_#{env["api.format"]}")
      in {dois: Array}
        stream PublicationsByDoiPresenter.new(params[:dois]).public_send("to_#{env["api.format"]}")
      else
        error!("The server does not support the functionality required to fulfill the request.", 501)
      end
    end
  end

  route(:any, "*path") { error!("Not found", 404) }
end
