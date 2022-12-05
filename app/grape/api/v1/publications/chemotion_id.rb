module API
  module V1
    module Publications
      class ChemotionId < Grape::API
        version "v1", using: :path

        namespace "/publications/chemotion_id" do
          desc "Get one publication via ChemotionID", {produces: %w[application/json application/xml text/csv]}
          # TODO:
          #   Allows direct list od ids and splits of an list of dois correctly (with ..._id/...,...,...)
          #   .xml / .json works
          #   While the current coerce_with works it will cast chars to 0 which results in the misleading message:
          #   -> "error": "Unprocessable Entity, 'id'=[12, 13, 0] not valid"
          #   Specs not yet adjusted to the new code
          params do
            requires :ids,
              type: Array[Integer],
              coerce_with: ->(val) { val.split(",").map(&:to_i) },
              desc: "ChemotionID"
          end
          route_param :ids do
            get do
              ids = params[:ids]
              # TODO: grape has an Option for custom types which can validate this + our .to_i in 'requires :ids...'
              if ids.any? { |param| param <= 0 } || ids.length == 0
                error!("Unprocessable Entity, 'id'=#{params[:ids]} not valid", 422)
              end

              case ids.size
              when 1
                present PublicationPresenter.present_by_chemotion_id ids.first
              else
                present PublicationsByChemotionIdPresenter.new ids
              end
            end
          end
        end

        route(:any, "*path") { error!("Not found", 404) }
      end
    end
  end
end
