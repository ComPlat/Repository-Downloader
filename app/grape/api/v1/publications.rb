class API::V1::Publications < Grape::API
  version "v1", using: :path

  namespace "/publications" do
    desc "Get publications via ChemotionID(s) or DOI(s)", {produces: %w[application/json application/xml text/csv application/zip]}
    params do
      optional :dois, type: Types::ValidDoiSet, desc: "List of DOIs, separated by comma"
      optional :chemotion_ids, type: Types::PositiveIntegerSet, desc: "List of Chemotion IDs, separated by comma"
      requires :format, type: Types::SupportedRenderingFormat, desc: "Rendering Format"
      exactly_one_of :chemotion_ids, :dois
    end
    get do
      case params
      in {chemotion_ids: Types::PositiveIntegerSet}
        stream PublicationsByChemotionIdPresenter.new(params[:chemotion_ids].value).public_send("to_#{params[:format].value}")
      in {dois: Types::ValidDoiSet}
        stream PublicationsByDoiPresenter.new(params[:dois].value).public_send("to_#{params[:format].value}")
      else
        error!("The server does not support the functionality required to fulfill the request.", 501)
      end
    end
  end

  route(:any, "*path") { error!("Not found", 404) }
end
